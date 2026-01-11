return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000, -- load before other UI stuff
    config = function()
      require("rose-pine").setup({
        variant = "main", -- main | moon | dawn
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
}

