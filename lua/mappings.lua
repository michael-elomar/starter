require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>yv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>yhv", "<cmd>hsplit<CR>", { desc = "Horizontal Split" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
