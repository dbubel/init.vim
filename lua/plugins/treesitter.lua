return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",        -- pin to latest tagged release (stable)
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        ensure_installed = { "go" },
        auto_install = true,
      })
    end,
  },
}

