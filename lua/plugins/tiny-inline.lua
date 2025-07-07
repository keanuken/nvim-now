require("tiny-inline-diagnostic").setup({
	preset = "minimal",
	transparent_bg = false,
	transparent_cursorline = false,
	hi = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
		arrow = "NonText",
		background = "CursorLine",
		mixing_color = "None",
	},
	options = {
		show_source = {
			enabled = false,
			if_many = false,
		},
		use_icons_from_diagnostic = false,
		set_arrow_to_diag_color = false,
		add_messages = true,
		softwrap = 30,
		multilines = {
			enabled = false,
			always_show = false,
		},
		show_all_diags_on_cursorline = false,
		enable_on_insert = false,
		enable_on_select = false,
		overflow = {
			mode = "wrap",
			padding = 3,
		},
		break_line = {
			enabled = false,
			after = 30,
		},
		format = nil,
		virt_texts = {
			priority = 2048,
		},
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},
		overwrite_events = nil,
	},
	disabled_ft = {},
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

-- Refresh diagnostics saat buffer dibuka dan LSP attach
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "LspAttach" }, {
	callback = function(args)
		vim.defer_fn(function()
			vim.diagnostic.show()
		end, 100)
	end,
})
