local map = vim.keymap.set

-- Keymap
map("n", "<leader>bd", function() require("mini.bufremove").delete() end, { noremap = true, desc = "Delete Buffer" })
