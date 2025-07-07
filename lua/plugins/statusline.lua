local M = {}

-- Cache untuk performa
local modes = {
	n = "N",
	i = "I",
	v = "V",
	V = "V",
	["\22"] = "VB", -- Visual Block
	c = "C",
	s = "S",
	S = "S",
	["\19"] = "S",
	t = "T",
	R = "R",
}

-- Komponen: Nama file dengan ikon
local function file_name()
	local fname = vim.fn.expand("%:.")
	if fname == "" then
		fname = "[No Name]"
	end
	local modified = vim.bo.modified and "[+]" or ""
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		vim.notify("nvim-web-devicons not loaded", vim.log.levels.WARN)
		return fname .. modified
	end
	local icon = devicons.get_icon(fname, vim.bo.filetype) or ""
	return string.format("%s %s%s", icon, fname, modified)
end

-- Komponen: Formatter
local function formatter()
	local formatters = {
		javascript = "prettier",
		typescript = "prettier",
		svelte = "prettier",
		html = "prettier",
		css = "prettier",
		lua = "stylua",
	}
	local ft = vim.bo.filetype
	return formatters[ft] or "none"
end

-- Komponen: Mode
local function mode()
	return modes[vim.fn.mode()] or "?"
end

-- Komponen: Nomor baris
local function line_number()
	return string.format("Ln %d", vim.fn.line("."))
end

-- Komponen: Diagnostics
local function diagnostics()
	local ok, counts = pcall(vim.diagnostic.get, 0)
	if not ok then
		vim.notify("Failed to get diagnostics: " .. tostring(counts), vim.log.levels.WARN)
		return ""
	end
	local error = 0
	local warn = 0
	for _, diag in ipairs(counts) do
		if diag.severity == vim.diagnostic.severity.ERROR then
			error = error + 1
		elseif diag.severity == vim.diagnostic.severity.WARN then
			warn = warn + 1
		end
	end
	local result = {}
	if error > 0 then
		table.insert(result, "✘" .. error)
	end
	if warn > 0 then
		table.insert(result, "▲" .. warn)
	end
	return table.concat(result, " ")
end

-- Fungsi utama untuk statusline
function M.statusline()
	local ok, result = pcall(function()
		return table.concat({
			"%#StatusLineFile#",
			file_name(),
			" ",
			"%#StatusLineSeparator#| ",
			"%#StatusLineFormatter#",
			formatter(),
			" ",
			"%#StatusLineSeparator#| %=",
			"%#StatusLineMode#",
			mode(),
			" ",
			"%#StatusLineSeparator#| ",
			"%#StatusLineLine#",
			line_number(),
			" ",
			"%#StatusLineSeparator#| ",
			"%#StatusLineError#",
			diagnostics(),
		})
	end)
	if not ok then
		vim.notify("Statusline error: " .. tostring(result), vim.log.levels.ERROR)
		return ""
	end
	return result
end

-- Setup statusline
function M.setup()
	-- Highlight grup dengan warna pastel
	local ok, _ = pcall(vim.api.nvim_set_hl, 0, "StatusLineFile", { fg = "#e0c4c9", bg = "NONE" }) -- Pink pastel
	if not ok then
		vim.notify("Failed to set StatusLineFile highlight", vim.log.levels.ERROR)
	end
	vim.api.nvim_set_hl(0, "StatusLineFormatter", { fg = "#f6e1b7", bg = "NONE" }) -- Kuning pastel
	vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#b3d9e0", bg = "NONE", bold = true }) -- Biru pastel
	vim.api.nvim_set_hl(0, "StatusLineLine", { fg = "#b7d9c9", bg = "NONE" }) -- Hijau pastel
	vim.api.nvim_set_hl(0, "StatusLineError", { fg = "#e0c4c9", bg = "NONE" }) -- Pink pastel untuk error
	vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "#f6e1b7", bg = "NONE" }) -- Kuning pastel untuk warning
	vim.api.nvim_set_hl(0, "StatusLineSeparator", { fg = "#d0d0d0", bg = "NONE" }) -- Abu-abu pastel untuk separator

	-- Set statusline dengan luaeval
	vim.o.statusline = "%!luaeval('require(\"plugins.statusline\").statusline()')"

	-- Refresh highlight saat tema berubah
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			vim.api.nvim_set_hl(0, "StatusLineFile", { fg = "#e0c4c9", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineFormatter", { fg = "#f6e1b7", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#b3d9e0", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "StatusLineLine", { fg = "#b7d9c9", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineError", { fg = "#e0c4c9", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "#f6e1b7", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineSeparator", { fg = "#d0d0d0", bg = "NONE" })
		end,
	})
end

-- Panggil setup
local ok, err = pcall(M.setup)
if not ok then
	vim.notify("Statusline setup failed: " .. tostring(err), vim.log.levels.ERROR)
end

return M
