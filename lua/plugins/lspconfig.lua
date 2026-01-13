return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config.gopls = {
      capabilities = capabilities,
    }
    vim.lsp.config.jsonls = {
      capabilities = capabilities,
    }
    vim.lsp.config.marksman = {
      capabilities = capabilities,
    }
    vim.lsp.enable("gopls")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("marksman")
  end,
}
