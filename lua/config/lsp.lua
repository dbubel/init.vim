-- Mason and LSP configuration
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls",
    "lua_ls",
    "eslint",
    "clangd", -- For C/C++ support
    "zls",    -- For Zig language support
  },
})

local lspconfig = require("lspconfig")

-- Set up capabilities for LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure gopls
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- Configure lua_ls
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Configure TypeScript LSP for JavaScript/TypeScript
-- Using the newer TypeScript LSP (ts_ls) instead of tsserver
-- Note: We don't need to explicitly set up ts_ls when using Volar with takeover mode

-- Configure Vue Language Server for Vue 3
lspconfig.volar.setup({
  capabilities = capabilities,
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  init_options = {
    typescript = {
      tsdk = vim.fn.expand('$HOME') ..
          '/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib'
    },
    vue = {
      hybridMode = false, -- Using Takeover Mode instead of Hybrid Mode
    },
    languageFeatures = {
      implementation = true,
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = true,
      rename = true,
      signatureHelp = true,
      codeAction = true,
      completion = {
        defaultTagNameCase = 'kebabCase',
        defaultAttrNameCase = 'kebabCase',
      },
      schemaRequestService = true,
      documentHighlight = true,
      documentLink = true,
      codeLens = true,
      diagnostics = true,
    }
  }
})

-- Configure ESLint
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- Configure clangd for C/C++
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      "compile_commands.json",
      "compile_flags.txt",
      ".git"
    )(fname)
  end,
})

-- Configure terraform-ls for Terraform
lspconfig.terraformls.setup({
  capabilities = capabilities,
  filetypes = { "terraform", "terraform-vars", "hcl" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      "*.tf",
      "*.tfvars",
      ".terraform",
      ".git"
    )(fname)
  end,
})

-- Configure zls for Zig
lspconfig.zls.setup({
  capabilities = capabilities,
  filetypes = { "zig", "zir" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      "build.zig",
      ".git"
    )(fname)
  end,
})
