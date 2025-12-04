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

-- Komponen: Ikon filetype
local function filetype_icon()
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		-- Fallback icons for common filetypes when devicons not available
		local fallback_icons = {
			lua = "",
			javascript = "",
			typescript = "",
			html = "",
			css = "",
			python = "",
			java = "",
			c = "",
			cpp = "",
			rust = "",
			go = "",
			php = "",
			ruby = "",
			vim = "",
			sh = "",
			markdown = "",
			json = "",
			yaml = "",
			toml = "",
		}
		return fallback_icons[vim.bo.filetype] or ""
	end

	-- Get icon by filetype first, then fallback to filename
	local icon, _ = devicons.get_icon_by_filetype(vim.bo.filetype)
	if not icon then
		local fname = vim.fn.expand("%:t") -- Just filename without path
		icon, _ = devicons.get_icon(fname, nil, { default = true })
	end

	return icon or ""
end

-- Komponen: Filetype display (readable format)
local function filetype_display()
	local ft = vim.bo.filetype
	if ft == "" then
		return ""
	end

	-- Convert common filetypes to readable names
	local readable_types = {
		javascript = "JavaScript",
		javascriptreact = "React JS",
		javascriptjsx = "React JSX",
		typescript = "TypeScript",
		typescriptreact = "React TS",
		typescripttsx = "React TSX",
		html = "HTML",
		css = "CSS",
		scss = "SCSS",
		sass = "SASS",
		less = "Less",
		lua = "Lua",
		python = "Python",
		java = "Java",
		c = "C",
		cpp = "C++",
		csharp = "C#",
		go = "Go",
		rust = "Rust",
		php = "PHP",
		ruby = "Ruby",
		perl = "Perl",
		swift = "Swift",
		kotlin = "Kotlin",
		scala = "Scala",
		haskell = "Haskell",
		erlang = "Erlang",
		elixir = "Elixir",
		clojure = "Clojure",
		scheme = "Scheme",
		racket = "Racket",
		vim = "Vim",
		sh = "Shell",
		bash = "Bash",
		zsh = "Zsh",
		fish = "Fish",
		markdown = "Markdown",
		json = "JSON",
		jsonc = "JSONC",
		yaml = "YAML",
		toml = "TOML",
		xml = "XML",
		sql = "SQL",
		dockerfile = "Docker",
		gitcommit = "Git",
		gitconfig = "Git Config",
		nginx = "Nginx",
		apache = "Apache",
	}

	-- Return readable name or capitalize first letter of filetype
	return readable_types[ft] or (ft:gsub("^%l", string.upper))
end

-- Komponen: Nama file dengan ikon
local function file_name()
	local fname = vim.fn.expand("%:.")
	if fname == "" then
		fname = "[No Name]"
	end
	local modified = vim.bo.modified and "[+]" or ""
	local icon = filetype_icon()
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

-- Komponen: Kapasitas baterai (Cross-platform)
local function battery_status()
	local ok, result = pcall(function()
		local percent = nil
		local os_name = vim.loop.os_uname().sysname

		-- macOS
		if os_name == "Darwin" then
			local handle = io.popen("pmset -g batt 2>/dev/null")
			if handle then
				local output = handle:read("*a")
				handle:close()
				percent = output:match("(%d+)%%")
			end

		-- Linux
		elseif os_name == "Linux" then
			-- Try upower first
			local handle = io.popen("upower -e 2>/dev/null")
			if handle then
				local output = handle:read("*a")
				handle:close()

				-- Find battery device
				local battery_path = output:match("(/org/freedesktop/UPower/devices/battery_[^\n]+)")
				if battery_path then
					local cmd = string.format("upower -i %s 2>/dev/null", battery_path)
					local handle2 = io.popen(cmd)
					if handle2 then
						local output2 = handle2:read("*a")
						handle2:close()
						percent = output2:match("percentage:%s*(%d+)%%")
					end
				end
			end

			-- Fallback to /sys/class/power_supply/
			if not percent then
				local handle = io.popen("cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1")
				if handle then
					local output = handle:read("*a")
					handle:close()
					percent = output:match("(%d+)")
				end
			end

		-- Windows (WSL or native)
		elseif os_name == "Windows_NT" or os_name:match("CYGWIN") or os_name:match("MINGW") then
			-- Try Windows Management Instrumentation
			local handle = io.popen('powershell -Command "Get-WmiObject Win32_Battery | Select-Object -ExpandProperty EstimatedChargeRemaining" 2>/dev/null')
			if handle then
				local output = handle:read("*a")
				handle:close()
				percent = output:match("(%d+)")
			end
		end

		-- Convert to number and validate
		if not percent then return "" end
		percent = tonumber(percent)
		if not percent or percent < 0 or percent > 100 then return "" end

		-- Tentukan ikon berdasarkan level baterai
		local icon
		if percent >= 90 then
			icon = "󰁹"  -- Full
		elseif percent >= 70 then
			icon = "󰂀"  -- High
		elseif percent >= 50 then
			icon = "󰁾"  -- Medium
		elseif percent >= 20 then
			icon = "󰁻"  -- Low
		else
			icon = "󰂃"  -- Critical
		end

		return string.format("%s %d%%", icon, percent)
	end)

	if not ok then
		return ""
	end

	return result
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
			filetype_display(),
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
			" ",
			"%#StatusLineSeparator#| ",
			"%#StatusLineBattery#",
			battery_status(),
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
	vim.api.nvim_set_hl(0, "StatusLineFormatter", { fg = "#b7d9c9", bg = "NONE" }) -- Hijau pastel untuk filetype
	vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#b3d9e0", bg = "NONE", bold = true }) -- Biru pastel
	vim.api.nvim_set_hl(0, "StatusLineLine", { fg = "#b7d9c9", bg = "NONE" }) -- Hijau pastel
	vim.api.nvim_set_hl(0, "StatusLineError", { fg = "#e0c4c9", bg = "NONE" }) -- Pink pastel untuk error
	vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "#f6e1b7", bg = "NONE" }) -- Kuning pastel untuk warning
	vim.api.nvim_set_hl(0, "StatusLineBattery", { fg = "#b3d9e0", bg = "NONE" }) -- Biru pastel untuk battery
	vim.api.nvim_set_hl(0, "StatusLineSeparator", { fg = "#d0d0d0", bg = "NONE" }) -- Abu-abu pastel untuk separator

	-- Set statusline dengan luaeval
	vim.o.statusline = "%!luaeval('require(\"plugins.statusline\").statusline()')"

	-- Refresh highlight saat tema berubah
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			vim.api.nvim_set_hl(0, "StatusLineFile", { fg = "#e0c4c9", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineFormatter", { fg = "#b7d9c9", bg = "NONE" }) -- Hijau pastel untuk filetype
			vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#b3d9e0", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "StatusLineLine", { fg = "#b7d9c9", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineError", { fg = "#e0c4c9", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineWarn", { fg = "#f6e1b7", bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineBattery", { fg = "#b3d9e0", bg = "NONE" })
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
