-- System stats (CPU, temp, memory, disk, load) for the statusline.
--
-- Everything is sampled in the background and cached, so statusline renders never block:
--   * CPU %   - deltas of vim.uv.cpu_info() between polls (no subprocess)
--   * load    - vim.uv.loadavg()
--   * disk    - vim.uv.fs_statfs() on the data volume
--   * memory  - macmon on Apple Silicon, else `vm_stat` (macOS) or uv available memory (Linux)
--   * temp    - macmon on Apple Silicon (`brew install macmon`), else /sys thermal zone (Linux)
local M = {}

local uv = vim.uv
local is_mac = uv.os_uname().sysname == "Darwin"

local INTERVAL_MS = 2000

M.stats = {} -- cpu, temp, mem_used, mem_total, disk_pct, load
M.enabled = true

local timer, macmon_job, prev_cpu

local function redraw()
  vim.schedule(function()
    vim.cmd.redrawstatus()
  end)
end

local function sample_cpu()
  local busy, total = 0, 0
  for _, core in ipairs(uv.cpu_info() or {}) do
    local t = core.times
    local sum = t.user + t.nice + t.sys + t.idle + t.irq
    total = total + sum
    busy = busy + sum - t.idle
  end
  if prev_cpu and total > prev_cpu.total then
    M.stats.cpu = (busy - prev_cpu.busy) / (total - prev_cpu.total) * 100
  end
  prev_cpu = { busy = busy, total = total }
end

local function sample_disk()
  local path = is_mac and uv.fs_stat("/System/Volumes/Data") and "/System/Volumes/Data" or "/"
  local s = uv.fs_statfs(path)
  if s and s.blocks > 0 then
    M.stats.disk_pct = (s.blocks - s.bavail) / s.blocks * 100
  end
end

-- macOS fallback when macmon isn't installed: approximate Activity Monitor's "Memory Used"
-- (app memory + wired + compressed).
local function sample_vm_stat()
  vim.system({ "vm_stat" }, { text = true }, function(res)
    if res.code ~= 0 then
      return
    end
    local out = res.stdout
    local page = tonumber(out:match("page size of (%d+)")) or 4096
    local function pages(label)
      return tonumber(out:match(label .. ":%s+(%d+)")) or 0
    end
    local used = pages("Anonymous pages") - pages("Pages purgeable") + pages("Pages wired down")
    used = used + pages("Pages occupied by compressor")
    M.stats.mem_used = used * page
    M.stats.mem_total = uv.get_total_memory()
  end)
end

local function sample_linux()
  M.stats.mem_total = uv.get_total_memory()
  M.stats.mem_used = M.stats.mem_total - (uv.get_available_memory and uv.get_available_memory() or uv.get_free_memory())
  local f = io.open("/sys/class/thermal/thermal_zone0/temp")
  if f then
    local milli = tonumber(f:read("*l"))
    f:close()
    M.stats.temp = milli and milli / 1000 or nil
  end
end

-- macmon streams one JSON object per line every interval.
local function start_macmon()
  if vim.fn.executable("macmon") ~= 1 then
    return false
  end
  local partial = ""
  macmon_job = vim.fn.jobstart({ "macmon", "pipe", "-i", tostring(INTERVAL_MS) }, {
    on_stdout = function(_, data)
      data[1] = partial .. data[1]
      partial = table.remove(data)
      for _, line in ipairs(data) do
        local ok, j = pcall(vim.json.decode, line)
        if ok and type(j) == "table" then
          if j.temp then
            M.stats.temp = j.temp.cpu_temp_avg
          end
          if j.memory then
            M.stats.mem_used = j.memory.ram_usage
            M.stats.mem_total = j.memory.ram_total
          end
        end
      end
    end,
    on_exit = function()
      macmon_job = nil
    end,
  })
  return macmon_job > 0
end

local function poll()
  sample_cpu()
  sample_disk()
  M.stats.load = { uv.loadavg() }
  if not is_mac then
    sample_linux()
  elseif not macmon_job then
    sample_vm_stat()
  end
  redraw()
end

function M.start()
  if timer then
    return
  end
  M.enabled = true
  if is_mac and vim.fn.executable("macmon") == 1 then
    start_macmon()
  end
  timer = uv.new_timer()
  timer:start(0, INTERVAL_MS, vim.schedule_wrap(poll))
end

function M.stop()
  M.enabled = false
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
  if macmon_job then
    vim.fn.jobstop(macmon_job)
    macmon_job = nil
  end
  prev_cpu = nil
  M.stats = {}
  redraw()
end

function M.toggle()
  if M.enabled and timer then
    M.stop()
  else
    M.start()
  end
end

-- Formatted lualine components ---------------------------------------------------------------

local function gib(bytes)
  return bytes / 1024 ^ 3
end

function M.cpu()
  local v = M.stats.cpu
  return v and string.format("\u{f4bc} %2.0f%%", v) or ""
end

function M.temp()
  local v = M.stats.temp
  return v and string.format("\u{f2c9} %.0f°C", v) or ""
end

function M.mem()
  local s = M.stats
  if not (s.mem_used and s.mem_total and s.mem_total > 0) then
    return ""
  end
  return string.format("\u{f035b} %.1f/%.0fG", gib(s.mem_used), gib(s.mem_total))
end

function M.disk()
  local v = M.stats.disk_pct
  return v and string.format("\u{f02ca} %.0f%%", v) or ""
end

function M.load()
  local l = M.stats.load
  return l and string.format("\u{f04c5} %.2f", l[1]) or ""
end

-- Threshold coloring (percentages / degrees) -------------------------------------------------

local function level_color(value, warn, crit)
  if not value then
    return nil
  end
  local ok, palettes = pcall(require, "catppuccin.palettes")
  local p = ok and palettes.get_palette("mocha") or { green = "#a6e3a1", yellow = "#f9e2af", red = "#f38ba8" }
  if value >= crit then
    return { fg = p.red }
  elseif value >= warn then
    return { fg = p.yellow }
  end
  return { fg = p.green }
end

function M.cpu_color()
  return level_color(M.stats.cpu, 50, 85)
end

function M.temp_color()
  return level_color(M.stats.temp, 70, 90)
end

function M.mem_color()
  local s = M.stats
  return level_color(s.mem_used and s.mem_total and s.mem_used / s.mem_total * 100, 75, 90)
end

function M.disk_color()
  return level_color(M.stats.disk_pct, 80, 95)
end

--- lualine component specs, in display order.
function M.components()
  local function cond()
    return M.enabled
  end
  return {
    { M.cpu, color = M.cpu_color, cond = cond },
    { M.temp, color = M.temp_color, cond = cond },
    { M.mem, color = M.mem_color, cond = cond },
    { M.disk, color = M.disk_color, cond = cond },
    { M.load, cond = cond },
  }
end

return M
