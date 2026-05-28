vim.g.barbar_auto_setup = false -- Nonaktifkan auto setup untuk kustomisasi

require("bufferline").setup({
	animation = true, -- Nonaktifkan animasi untuk performa
	auto_hide = false, -- Selalu tampilkan tabline
	no_name_title = nil,
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
