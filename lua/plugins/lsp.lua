return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Completion capabilities for every server
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Per-server settings (merged on top of nvim-lspconfig defaults)
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
              unusedparams = true,
              unusedwrite = true,
              nilness = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = true },
            },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = "always" },
          },
        },
      })

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" }, -- schemastore.nvim provides these
            schemas = vim.tbl_extend("force", require("schemastore").yaml.schemas(), {
              kubernetes = {
                "k8s/**/*.yaml",
                "k8s/**/*.yml",
                "kubernetes/**/*.yaml",
                "kubernetes/**/*.yml",
                "manifests/**/*.yaml",
                "*.k8s.yaml",
                "*deployment*.yaml",
                "*service*.yaml",
                "*ingress*.yaml",
                "*configmap*.yaml",
                "*secret*.yaml",
              },
            }),
            format = { enable = false }, -- prettier handles formatting
          },
        },
      })

      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            disableOrganizeImports = true, -- ruff does this
            analysis = { typeCheckingMode = "standard" },
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- zls is built from source (~/.local/src/zls) to match Zig 0.17; Mason only ships 0.16.
      -- Once zls 0.17.0 is tagged, this can go back to the Mason package.
      vim.lsp.config("zls", {
        cmd = { vim.fn.expand("~/.local/bin/zls") },
        settings = {
          zls = {
            zig_exe_path = "/opt/homebrew/bin/zig",
            enable_build_on_save = true,
            semantic_tokens = "partial",
          },
        },
      })
      vim.lsp.enable("zls")

      -- Install servers + tools, auto-enable installed servers
      require("mason-lspconfig").setup({ automatic_enable = true })
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Language servers (mason package names)
          "gopls",
          "vtsls",
          "eslint-lsp",
          "terraform-ls",
          "dockerfile-language-server",
          "docker-compose-language-service",
          "json-lsp",
          "yaml-language-server",
          "marksman",
          "basedpyright",
          "ruff",
          "lua-language-server",
          "bash-language-server",
          -- Formatters / linters
          "gofumpt",
          "goimports",
          "prettier",
          "stylua",
          "shfmt",
          "hadolint",
          "golangci-lint",
        },
      })

      -- Buffer-local keymaps once a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(ev)
          local function bmap(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          local tb = require("telescope.builtin")

          bmap("n", "gd", tb.lsp_definitions, "Goto definition")
          bmap("n", "gr", tb.lsp_references, "Goto references")
          bmap("n", "gI", tb.lsp_implementations, "Goto implementation")
          bmap("n", "gy", tb.lsp_type_definitions, "Goto type definition")
          bmap("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
          bmap("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, "Hover documentation")
          bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          bmap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          bmap("n", "<leader>fs", tb.lsp_document_symbols, "Document symbols")
          bmap("n", "<leader>fS", tb.lsp_dynamic_workspace_symbols, "Workspace symbols")
          bmap("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            bmap("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, "Toggle inlay hints")
          end
        end,
      })
    end,
  },
}
