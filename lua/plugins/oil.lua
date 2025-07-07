local map = vim.keymap.set

-- Setup Oil
require("oil").setup({
	-- Floating window untuk estetika
	view_options = {
		show_hidden = true, -- Tampilkan file hidden
	},
	float = {
		padding = 2,
		max_width = 60,
		max_height = 20,
	},
	keymaps = {
		["<C-s>"] = false,
	},
})

-- Keymap
map("n", "-", "<CMD>lua require('oil').open_float()<CR>", { desc = "Open parent directory in floating window" })
