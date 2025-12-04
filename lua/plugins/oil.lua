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

-- Auto-cleanup empty buffers created by Oil
vim.api.nvim_create_autocmd("User", {
	pattern = "OilEnter",
	callback = function()
		-- Small delay to let Oil finish opening
		vim.defer_fn(function()
			local bufs = vim.api.nvim_list_bufs()
			for _, buf in ipairs(bufs) do
				if vim.api.nvim_buf_is_loaded(buf) and
				   vim.api.nvim_buf_get_name(buf) == "" and
				   vim.api.nvim_buf_line_count(buf) == 1 and
				   vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
					-- Check if this buffer is not the current buffer and not visible
					local current_buf = vim.api.nvim_get_current_buf()
					if buf ~= current_buf then
						pcall(vim.api.nvim_buf_delete, buf, { force = true })
					end
				end
			end
		end, 50) -- 50ms delay
	end,
})

