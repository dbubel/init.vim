return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "terraformls", "yamlls", "pylsp", "gopls", "lua_ls", "zls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.zls.setup({ capabilities = capabilities })
			lspconfig.pylsp.setup({ capabilities = capabilities })
			lspconfig.yamlls.setup({ capabilities = capabilities })
			lspconfig.terraformls.setup({ capabilities = capabilities })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", ":Telescope lsp_references <CR>", {})
			vim.keymap.set("n", "ra", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "ls", vim.lsp.buf.signature_help, {})
		end,
	},
}
