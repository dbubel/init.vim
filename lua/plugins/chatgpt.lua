-- Lazy
return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup()
			vim.keymap.set("n", "<leader>ai", "<cmd> ChatGPT <CR>")
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim", -- optional
		"nvim-telescope/telescope.nvim",
	},
}
