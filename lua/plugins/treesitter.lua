require("nvim-treesitter.configs").setup({
	-- Parser yang diinstall untuk webdev
	ensure_installed = {
		"javascript",
		"typescript",
		"tsx",
		"svelte",
		"html",
		"css",
		"lua",
		"http",
		"prisma",
	},
	-- Install parser secara otomatis saat membuka file baru
	auto_install = true,
	-- Aktifkan syntax highlighting
	highlight = {
		enable = true,
		-- Nonaktifkan untuk file besar (>100KB) untuk performa
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		-- Gunakan treesitter untuk semua bahasa kecuali regex
		additional_vim_regex_highlighting = false,
	},
	-- Aktifkan incremental selection
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
			scope_incremental = "<C-s>",
			node_decremental = "<C-Backspace>",
		},
	},
	-- Aktifkan textobjects untuk navigasi kode
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["at"] = "@template.outer", -- Tambah: seluruh template literal
				["it"] = "@template.inner", -- Tambah: isi template literal
			},
			query = {
				javascript = [[
        (template_string) @template.outer
        (template_string (template_literal) @template.inner)
        (template_string (template_substitution) @template.inner)
      ]],
			},
		},
	},
	-- Aktifkan folding berdasarkan treesitter
	fold = {
		enable = true,
	},
})

-- Setup folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Jangan fold saat buka file
vim.opt.foldlevel = 99 -- Buka semua fold secara default
