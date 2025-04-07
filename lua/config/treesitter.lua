-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = { 
    "go", "lua", "vim", "vimdoc", "query", "sql",
    -- Web development
    "javascript", "typescript", "vue", "html", "css", "scss", "json",
    -- C programming
    "c", "cmake", "make"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
