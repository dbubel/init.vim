-- Keymaps
local keymap = vim.keymap.set

-- Gitsigns keymaps
keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
keymap("n", "<leader>hD", ":Gitsigns diffthis<CR>", { desc = "Show git diff" })
keymap("n", "<leader>hf", ":Gitsigns next_hunk<CR>", { desc = "Go to next git hunk" })
keymap("n", "<leader>hb", ":Gitsigns prev_hunk<CR>", { desc = "Go to previous git hunk" })
keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })

-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
keymap("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in buffer" })
keymap("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Projects" })

-- System clipboard keymaps
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Saving and command mode
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", ";", ":", { desc = "Quick command mode" })

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Window resizing
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Line number toggles
keymap("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
keymap("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- Buffer management
keymap("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
keymap("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close current buffer" })
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Terminal mappings
keymap("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float terminal" })
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical terminal" })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufopts = { noremap = true, silent = true, buffer = args.buf }
    keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap("n", "gr", require('telescope.builtin').lsp_references, bufopts)
    keymap("n", "ra", vim.lsp.buf.rename, bufopts)
    keymap("n", "K", vim.lsp.buf.hover, bufopts)
    keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap("n", "<leader>fm", vim.lsp.buf.format, bufopts)
    keymap("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    keymap("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  end,
})
