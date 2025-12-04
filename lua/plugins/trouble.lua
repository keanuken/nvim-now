require("trouble").setup({
	auto_open = false,
	auto_close = false,
	use_diagnostic_signs = true,
	signs = {
		error = "✘",
		warning = "▲",
		hint = "⚑",
		information = "»",
	},
})

-- Refresh diagnostics saat masuk buffer
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
	callback = function()
		local ok, err = pcall(require("trouble").refresh)
		if not ok then
			vim.notify("Trouble: Failed to refresh diagnostics: " .. err, vim.log.levels.ERROR)
		end
	end,
})
