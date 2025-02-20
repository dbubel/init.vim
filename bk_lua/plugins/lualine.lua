-- return {
--   "nvim-lualine/lualine.nvim",
--   config = function()
--     require("lualine").setup({
--       options = {
--         theme = "dracula",
--       },
--     })
--   end,
-- }
-- Ensure you have 'folke/lazy.nvim' installed and configured in your Neovim setup

-- require('lazy').setup({
-- Add lualine.nvim to the list of plugins
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	config = function()
		-- Call the lualine setup function within the config block
		require("lualine").setup({
			options = {
				theme = "auto", -- You can change this to any theme you prefer
				section_separators = { "", "" },
				component_separators = { "", "" },
				icons_enabled = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"filename",
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
-- })
