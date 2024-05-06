-- yank in to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>")

-- move windows up down left right
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- line numbers normal and relative
vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>")
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>")
-- new buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>")
-- close buffer
vim.keymap.set("n", "<leader>x", "<cmd> bd <CR>")
