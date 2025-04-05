-- Keymaps
local keymap = vim.keymap.set

-- Gitsigns keymaps
keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
keymap("n", "<leader>hD", ":Gitsigns diffthis<CR>", { desc = "Show git diff" })
keymap("n", "<leader>hf", ":Gitsigns next_hunk<CR>", { desc = "Go to next git hunk" })
keymap("n", "<leader>hb", ":Gitsigns prev_hunk<CR>", { desc = "Go to previous git hunk" })
keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })

-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- System clipboard keymaps
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Saving and command mode
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", ";", ":", { desc = "Quick command mode" })

-- Clear search highlights
keymap("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", {  desc = "Move to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Line number toggles
keymap("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
keymap("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- Buffer management
keymap("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
keymap("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close current buffer" })

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
    keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap("n", "<leader>fm", vim.lsp.buf.format, bufopts)
  end,
})
