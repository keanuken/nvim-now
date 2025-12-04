-- Load which-key safely with lazy loading
local function setup_keymaps(wk)
	-- Which-Key integration for existing keymaps
	wk.add({
		-- Root level mappings
		{ "<C-s>", desc = "Save File" },

		-- Find/Files group
		{ "<leader>f", group = "Find/Files" },
		{ "<leader>ff", desc = "Find Files (Buffer Dir)" },
		{ "<leader>fp", desc = "Find Files (Project Root)" },
		{ "<leader>fc", desc = "Find Config Files" },
		{ "<leader>fo", desc = "Find Buffers" },
		{ "<leader>th", desc = "Colorscheme Picker" },

		-- Grep group
		{ "<leader>g", group = "Grep" },
		{ "<leader>gg", desc = "Live Grep" },
		{ "<leader>gb", desc = "Grep in Current Buffer" },
		{ "<leader>gd", desc = "Grep in Current Directory" },
		{ "<leader>gp", desc = "Grep in Project Root" },

		-- Code/LSP group
		{ "<leader>c", group = "Code/LSP" },
		{ "<leader>ca", desc = "Code Action (Quick)" },
		{ "<leader>cae", desc = "Code Actions (Enhanced Menu)" },
		{ "<leader>rn", desc = "Rename" },
		{ "<leader>cm", desc = "Open Mason" },
		{ "gd", desc = "Go to Definition" },
		{ "K", desc = "Hover Documentation" },

		-- Diagnostics group
		{ "<leader>x", group = "Diagnostics" },
		{ "<leader>xx", desc = "Toggle Diagnostics" },
		{ "<leader>xX", desc = "Buffer Diagnostics" },

		-- Buffers group
		{ "<leader>b", group = "Buffers" },
		{ "<leader>bd", desc = "Delete Buffer" },
		{ "<leader>bp", desc = "Pin Buffer" },
		{ "<leader>1", desc = "Go to Buffer 1" },
		{ "<leader>2", desc = "Go to Buffer 2" },
		{ "<leader>3", desc = "Go to Buffer 3" },
		{ "<leader>4", desc = "Go to Buffer 4" },
		{ "<leader>5", desc = "Go to Buffer 5" },

		-- Windows group
		{ "<leader>w", group = "Windows" },
		{ "<leader>wq", desc = "Write and Quit All" },

		-- Split group
		{ "<leader>s", group = "Split" },
		{ "ss", desc = "Split Horizontal" },
		{ "sv", desc = "Split Vertical" },
		{ "sh", desc = "Move Left" },
		{ "sj", desc = "Move Down" },
		{ "sk", desc = "Move Up" },
		{ "sl", desc = "Move Right" },
		{ "sq", desc = "Close Window" },

		-- Other mappings
		{ "-", desc = "Open Oil (File Explorer)" },
		{ "H", desc = "Previous Buffer" },
		{ "L", desc = "Next Buffer" },
		{ "<C-w>", desc = "Close Buffer" },
		{ "jj", desc = "Exit Insert Mode", mode = "i" },
	})
end

local function setup_which_key()
	local ok, wk = pcall(require, "which-key")
	if not ok then
		-- Schedule setup for when which-key becomes available
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			callback = function()
				local ok2, wk2 = pcall(require, "which-key")
				if ok2 then
					setup_keymaps(wk2)
				end
			end,
		})
		return
	end
	setup_keymaps(wk)
end

-- Initialize which-key setup
setup_which_key()
