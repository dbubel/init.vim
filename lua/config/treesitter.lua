-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "lua", "vim", "vimdoc", "query", "sql" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
