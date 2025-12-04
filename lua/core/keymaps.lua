local map = vim.keymap.set

-- === NAVIGATION ===
map("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
map("n", "<leader>wq", ":wqa<CR>", { noremap = true, silent = true, desc = "Write and Quit All" })
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save File" })
map("n", "ss", ":split<CR>", { noremap = true, silent = true, desc = "Split Window Horizontal" })
map("n", "sv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split Window Vertical" })
map("n", "sl", "<C-w>l", { desc = "Move to Right Window" })
map("n", "sj", "<C-w>j", { desc = "Move to Down Window" })
map("n", "sk", "<C-w>k", { desc = "Move to Up Window" })
map("n", "sh", "<C-w>h", { desc = "Move to Left Window" })
map("n", "sq", "<C-w>q", { desc = "Close Current Window" })

-- === PLUGINS ===

-- Oil
map("n", "-", "<CMD>lua require('oil').open_float()<CR>", { desc = "Open parent directory in floating window" })

-- Barbar (Buffer Navigation)
map("n", "L", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
map("n", "H", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
map("n", "<C-w>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
map("n", "<Leader>bp", "<Cmd>BufferPin<CR>", { noremap = true, silent = true, desc = "Pin Buffer" })
map("n", "<Leader>1", "<Cmd>BufferGoto 1<CR>", { noremap = true, silent = true, desc = "Go to Buffer 1" })
map("n", "<Leader>2", "<Cmd>BufferGoto 2<CR>", { noremap = true, silent = true, desc = "Go to Buffer 2" })
map("n", "<Leader>3", "<Cmd>BufferGoto 3<CR>", { noremap = true, silent = true, desc = "Go to Buffer 3" })
map("n", "<Leader>4", "<Cmd>BufferGoto 4<CR>", { noremap = true, silent = true, desc = "Go to Buffer 4" })
map("n", "<Leader>5", "<Cmd>BufferGoto 5<CR>", { noremap = true, silent = true, desc = "Go to Buffer 5" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })

-- Mini Bufremove
map("n", "<leader>bd", function() require("mini.bufremove").delete() end, { noremap = true, desc = "Delete Buffer" })

-- Telescope
map("n", "<leader>ff", function()
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir

	if current_file and current_file ~= "" then
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end
	if current_dir and current_dir ~= "" then
		require("telescope.builtin").find_files({
			cwd = current_dir,
			hidden = true,  -- ✅ Show hidden files
		})
	else
		require("telescope.builtin").find_files({
			hidden = true,  -- ✅ Show hidden files
		})
		vim.notify(
			"Could not determine current buffer's directory, falling back to global find_files.",
			vim.log.levels.INFO
		)
	end
end, { desc = "Telescope: Files (Buffer Dir)" })

map("n", "<leader>fp", function()
	local telescope_custom = require("plugins.telescope")
	telescope_custom.find_files_from_project_root()
end, { desc = "Telescope: Files (Project Root)" })

map("n", "<leader>fc", function()
	local telescope_custom = require("plugins.telescope")
	telescope_custom.find_config_files()
end, { desc = "Telescope: Find Config Files" })

map("n", "<leader>gg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })

map("n", "<leader>gb", function()
	local telescope_custom = require("plugins.telescope")
	telescope_custom.grep_in_current_buffer()
end, { desc = "Grep in Current Buffer" })

map("n", "<leader>gd", function()
	local telescope_custom = require("plugins.telescope")
	telescope_custom.grep_in_current_directory()
end, { desc = "Grep in Current Directory" })

map("n", "<leader>gp", function()
	local telescope_custom = require("plugins.telescope")
	telescope_custom.grep_in_project_root()
end, { desc = "Grep in Project Root" })

map("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "Open Buffers" })

map("n", "<leader>th", function()
	local telescope_custom = require("plugins.telescope") -- Load custom module
	require("telescope.builtin").colorscheme({
		attach_mappings = function(prompt_bufnr, map_func)
			-- Use functions from custom module
			map_func("i", "<CR>", telescope_custom.colorscheme_with_save)
			map_func("n", "<CR>", telescope_custom.colorscheme_with_save)
			return true
		end,
	})
end, { desc = "Colorscheme Picker" })

-- Mason
map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Enhanced Code Actions with Dressing UI
map("n", "<leader>cae", function()
	local telescope_custom = require("plugins.telescope")
	telescope_custom.code_actions_enhanced()
end, { desc = "Code Actions (Enhanced Menu)" })