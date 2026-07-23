local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.showmode = false -- statusline shows the mode
opt.winborder = "rounded" -- rounded borders for all floating windows
opt.pumheight = 10
opt.laststatus = 3 -- global statusline
opt.inccommand = "split" -- live preview of :substitute

-- Editing
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.wrap = false
opt.mouse = "a"
opt.confirm = true -- prompt instead of failing on unsaved changes
opt.virtualedit = "block" -- allow cursor past EOL in visual block

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Files
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 300 -- faster which-key popup

-- Folding (treesitter-based)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = ""

-- Sync with system clipboard (scheduled to not slow startup)
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { source = "if_many", spacing = 2 },
  float = { border = "rounded", source = "if_many" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})
