-- plugins/tiny-inline.lua
require("tiny-inline-diagnostic").setup({
	signs = {
		left = "",
		right = "",
		diag = "●",
		arrow = "    ",
		up_arrow = "    ",
		vertical = " │",
		vertical_end = " └",
	},
	hi = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
		arrow = "NonText",
		background = "CursorLine",
		mixing_color = "None",
	},
	blend = {
		factor = 0.27,
	},
	options = {
		show_source = true,
		throttle = 20,
		softwrap = 15,
		multiple_diag_under_cursor = true,
		multilines = false,
		overflow = {
			mode = "wrap",
		},
		break_line = {
			enabled = false,
			after = 30,
		},
	},
})

vim.diagnostic.config({ virtual_text = false })
