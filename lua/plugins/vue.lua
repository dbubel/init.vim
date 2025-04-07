return {
  -- Vue 3 support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vue", "typescript", "javascript" },
    },
  },
  
  -- Vue syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vue", "typescript", "javascript", "html", "css" })
      end
    end,
  },
}