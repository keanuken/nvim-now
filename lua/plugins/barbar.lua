vim.g.barbar_auto_setup = false -- Nonaktifkan auto setup untuk kustomisasi

require("bufferline").setup({
	animation = false, -- Nonaktifkan animasi untuk performa
	auto_hide = false, -- Selalu tampilkan tabline
	tabpages = true, -- Tampilkan tab pages
	closable = true, -- Aktifkan ikon "X" untuk tutup tab
	clickable = true, -- Aktifkan klik mouse untuk navigasi
	icons = {
		button = "×", -- Ikon "X" untuk tombol tutup
		modified = { button = "●" }, -- Indikator buffer dimodifikasi
		pinned = { button = "📌" }, -- Ikon untuk buffer yang dipin
		separator = { left = "▎", right = "" }, -- Separator antar tab
		filetype = { enabled = true }, -- Aktifkan ikon file
	},
	-- sidebar_filetypes = {
	-- 	Oil = { event = "BufWipeout" }, -- Integrasi dengan oil.nvim
	-- },
})

-- Keymaps untuk navigasi buffer
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "L", "<Cmd>BufferNext<CR>", opts) -- Buffer berikutnya
map("n", "H", "<Cmd>BufferPrevious<CR>", opts) -- Buffer sebelumnya
map("n", "<C-w>", "<Cmd>BufferClose<CR>", opts) -- Tutup buffer
map("n", "<Leader>bp", "<Cmd>BufferPin<CR>", opts) -- Pin buffer
map("n", "<Leader>1", "<Cmd>BufferGoto 1<CR>", opts) -- Ke buffer 1
map("n", "<Leader>2", "<Cmd>BufferGoto 2<CR>", opts) -- Ke buffer 2
map("n", "<Leader>3", "<Cmd>BufferGoto 3<CR>", opts) -- Ke buffer 3
map("n", "<Leader>4", "<Cmd>BufferGoto 4<CR>", opts) -- Ke buffer 4
map("n", "<Leader>5", "<Cmd>BufferGoto 5<CR>", opts) -- Ke buffer 5
