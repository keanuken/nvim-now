local map = vim.keymap.set

-- === NAVIGATION ===
map("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
map("n", "<leader>wq", ":wqa<CR>", { noremap = true, silent = true, desc = "Write and Quit All" })
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save File" })
map("n", "ss", ":split<CR>", { noremap = true, silent = true, desc = "Split Window Horizontal" })
map("n", "sv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split Window Vertical" })
map("n", "sl", "<C-w>l", { desc = "Move to Right Window" })
map("n", "sj", "<C-w>j", { desc = "Move to Down Window" })
map("n", "sk", "<C-w>k", { desc = "Move to Up Window" })
map("n", "sh", "<C-w>h", { desc = "Move to Left Window" })
map("n", "sq", "<C-w>q", { desc = "Close Current Window" })
