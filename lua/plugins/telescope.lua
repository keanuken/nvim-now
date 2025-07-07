-- Konfigurasi Telescope.nvim dengan tema selector
local map = vim.keymap.set
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

-- Setup Telescope
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = { width = 0.8, height = 0.9 },
		},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		file_ignore_patterns = { "node_modules/", "%.git/" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<CR>"] = actions.select_default,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
			theme = "dropdown",
			layout_config = {
				width = 0.4,
				height = 0.5,
			},
		},
	},
})

-- Fungsi untuk simpan tema permanen
local function save_theme(theme)
	local config_path = vim.fn.stdpath("config") .. "/lua/theme.lua"
	local ok, file = pcall(io.open, config_path, "w")
	if not ok or not file then
		vim.notify("Failed to open theme.lua: " .. (file or "unknown error"), vim.log.levels.ERROR)
		return false
	end
	local success, err = pcall(function()
		file:write(string.format('vim.cmd.colorscheme("%s")\n', theme))
		file:write('vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", fg = "#7f7f7f" })\n')
		file:write('vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", ctermbg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE", link = "Normal" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", link = "Comment" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE", link = "Comment" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE", link = "Comment" })\n')
		file:write('vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE", link = "Comment" })\n')
		file:write('vim.api.nvim_set_hl(0, "OilDir", { link = "Directory" })\n')
		file:write('vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "NONE", link = "Normal" })\n')
		file:write('vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "NONE", fg = "#ffffff", bold = true })\n')
		file:write('vim.api.nvim_set_hl(0, "BufferVisible", { bg = "NONE", fg = "#aaaaaa" })\n')
		file:write('vim.api.nvim_set_hl(0, "BufferInactive", { bg = "NONE", fg = "#7f7f7f" })\n')
		file:write('vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = "NONE", link = "BufferCurrent" })\n') -- Atau link ke "Normal"
		file:write('vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = "NONE", link = "BufferVisible" })\n') -- Atau link ke "Normal"
		file:write(
			'vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "NONE", link = "BufferInactive", italic = true })\n'
		)
		file:write('vim.api.nvim_set_hl(0, "BufferTabpages", { bg = "NONE" })\n')
		file:write('vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "ErrorMsg" })\n')
		file:write('vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "WarningMsg" })\n')
		file:write('vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "NONE", link = "Normal" })\n')
		file:close()
	end)
	if not success then
		vim.notify("Failed to write theme.lua: " .. err, vim.log.levels.ERROR)
		return false
	end
	local ok, err = pcall(vim.cmd, "source " .. config_path)
	if not ok then
		vim.notify("Failed to source theme.lua: " .. err, vim.log.levels.ERROR)
		return false
	end
	vim.notify("Theme " .. theme .. " saved and applied permanently", vim.log.levels.INFO)
	return true
end

-- Custom action untuk colorscheme picker
local function colorscheme_with_save(prompt_bufnr)
	local action_state = require("telescope.actions.state")
	local picker = action_state.get_current_picker(prompt_bufnr)
	local selected = picker:get_selection()
	local theme = selected.value
	-- Load plugin tema jika bukan bawaan
	local non_builtin_themes = { ["rose-pine"] = true }
	if non_builtin_themes[theme] then
		local ok, err = pcall(require, theme)
		if not ok then
			vim.notify("Failed to load theme " .. theme .. ": " .. err, vim.log.levels.ERROR)
			return
		end
	end
	-- Terapkan tema
	local ok, err = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.notify("Failed to apply theme " .. theme .. ": " .. err, vim.log.levels.ERROR)
		return
	end
	-- Set highlight untuk sesi saat ini
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", link = "Comment" })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE", link = "Comment" })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE", link = "Comment" })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE", link = "Comment" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "NONE", fg = "#ffffff", bold = true })
	vim.api.nvim_set_hl(0, "BufferVisible", { bg = "NONE", fg = "#aaaaaa" })
	vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "NONE", fg = "#aaaaaa" })
	vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = "NONE", link = "BufferCurrent" })
	vim.api.nvim_set_hl(0, "BufferVisibleMod", { bg = "NONE", link = "BufferVisible" })
	vim.api.nvim_set_hl(0, "BufferInactiveMod", { bg = "NONE", fg = "#aaaaaa", italic = true })
	vim.api.nvim_set_hl(0, "BufferInactive", { bg = "NONE", fg = "#7f7f7f" })
	vim.api.nvim_set_hl(0, "BufferTabpages", { bg = "NONE" })
	-- Simpan tema
	if save_theme(theme) then
		actions.close(prompt_bufnr)
	end
end

return {
	colorscheme_with_save = colorscheme_with_save,
	save_theme = save_theme,
}
-- Keymap untuk tema selector
-- map("n", "<leader>th", function()
-- 	builtin.colorscheme({
-- 		attach_mappings = function(prompt_bufnr, map)
-- 			map("i", "<CR>", colorscheme_with_save)
-- 			map("n", "<CR>", colorscheme_with_save)
-- 			return true
-- 		end,
-- 	})
-- end, { desc = "Telescope: Colorscheme picker" })
--
-- -- Keymap existing
-- map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Files (Project)" })
-- map("n", "<leader>gg", builtin.live_grep, { desc = "Telescope: Grep (Project)" })
-- map("n", "<leader>fo", builtin.buffers, { desc = "Telescope: Open Buffers" })
