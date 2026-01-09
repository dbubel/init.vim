-- General keybinds
vim.keymap.set("n", ";", ":", { desc = "Quick command mode" })

-- LSP keybinds
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "ra", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
  vim.defer_fn(function()
    vim.lsp.buf.format()
  end, 100)
end, { desc = "Organize imports and format" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Telescope keybinds
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find grep" })
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in file" })
vim.keymap.set("n", "<leader>a", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })

-- Gitsigns keybinds
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>hf", "<cmd>Gitsigns next_hunk<cr>", { desc = "Hunk forward" })
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Hunk back" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

-- File explorer
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
