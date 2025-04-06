local dap = require("dap")
local dapui = require("dapui")

-- Set up breakpoint and stopped point icons with better visibility
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "⭕", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⏸️", texthl = "DiagnosticSignWarn", linehl = "CursorLine", numhl = "" })

-- Enable DAP logging
vim.fn.mkdir(vim.fn.stdpath("log") .. "/dap", "p")
local dap_log_file = vim.fn.stdpath("log") .. "/dap/dap.log"
vim.g.dap_log_file = dap_log_file

-- Enable DAP debug logging
dap.set_log_level("TRACE")

-- NOTE: Go adapter and configuration are now fully managed by nvim-dap-go
-- See lua/plugins/go.lua for configuration details

-- DAP UI setup with improved settings
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Customize UI layout to show more information
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.4 },
        { id = "breakpoints", size = 0.15 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.2 },
      },
      size = 0.3,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 0.27,
      position = "bottom",
    },
  },
  -- Floating windows configuration
  floating = {
    max_height = nil,
    max_width = nil,
    border = "rounded",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
})

-- Automatically open dapui when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Automatically close dapui when debugging ends
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

