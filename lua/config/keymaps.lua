-- LSP keybinds
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "ra", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Telescope keybinds
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find grep" })
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in file" })
