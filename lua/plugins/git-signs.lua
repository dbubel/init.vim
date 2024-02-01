return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({})
    vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk <CR>", {})
    vim.keymap.set("n", "<leader>hD", ":Gitsigns diffthis <CR>", {})
    vim.keymap.set("n", "<leader>hf", ":Gitsigns next_hunk <CR>", {})
    vim.keymap.set("n", "<leader>hb", ":Gitsigns prev_hunk <CR>", {})
    vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk <CR>", {})
	end,
}

