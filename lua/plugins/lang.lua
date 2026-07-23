return {
  -- Pretty in-buffer markdown rendering (headings, tables, checkboxes, code blocks)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      completions = { blink = { enabled = true } },
    },
  },
}
