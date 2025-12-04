return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
			require("nvim-web-devicons").setup({
				default = true, -- Aktifkan ikon default
			})
		end,
	},
	-- Telescope: Pencarian cepat
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- keys moved to core/keymaps.lua
	},

	-- Oil: File explorer ringan
	{
		"stevearc/oil.nvim",
		-- keys moved to core/keymaps.lua
		config = function()
			require("plugins.oil")
		end,
	},

	-- Trouble: Diagnostics dan quickfix UI
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Diagnostics" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
		},
		config = function()
			require("plugins.trouble")
		end,
	},

	-- mini.bufremove: Hapus buffer tanpa ganggu layout
	{
		"echasnovski/mini.bufremove",
		keys = { { "<leader>bd", mode = "n", desc = "Delete Buffer" } },
		config = function()
			require("plugins.mini-bufremove")
		end,
	},

	-- Mason: Package manager untuk LSP dan tools
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		keys = { { "<leader>cm", "<cmd>Mason<cr>", mode = "n", desc = "Open Mason" } },
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason-LSPConfig: Jembatan Mason ke lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp")
		end,
	},

	-- Mason-Tool-Installer: Install formatters/linters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
	},

	-- nvim-cmp: Autocompletion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("plugins.cmp")
		end,
	},

	-- cmp-nvim-lsp: LSP source untuk nvim-cmp
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
	},

	-- tiny-inline-diagnostic: Inline diagnostics
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("plugins.tiny-inline")
		end,
	},

	-- conform.nvim: Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("plugins.conform")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Tambah ini
		config = function()
			require("plugins.treesitter")
		end,
	},
	-- barbar.nvim: Buffer tab management
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.barbar")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true, -- Transparansi untuk Normal
				disable_float_background = true, -- Transparansi untuk floating windows
				styles = { italic = false },
				highlight_groups = {
					TelescopeNormal = { bg = "NONE" },
					TelescopePromptNormal = { bg = "NONE" },
					TelescopeResultsNormal = { bg = "NONE" },
					TelescopePreviewNormal = { bg = "NONE" },
					TelescopeBorder = { bg = "NONE" },
					TelescopePromptBorder = { bg = "NONE" },
					TelescopeResultsBorder = { bg = "NONE" },
					TelescopePreviewBorder = { bg = "NONE" },
					NormalNC = { bg = "NONE" },
					BufferTabpageFill = { bg = "NONE" },
					BufferCurrent = { bg = "NONE", fg = "text", bold = true },
					BufferVisible = { bg = "NONE", fg = "subtle" },
					BufferInactive = { bg = "NONE", fg = "#aaaaaa" }, -- Kontras lebih terang
					BufferInactiveSign = { bg = "NONE", fg = "#aaaaaa" },
					BufferInactiveMod = { bg = "NONE", fg = "#aaaaaa", italic = true },
					BufferTabpages = { bg = "NONE" },
				},
			})
		end,
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		priority = 1000,
		name = "poimandres",
		config = function()
			require("poimandres").setup({
				disable_background = true, -- Transparansi untuk Normal
				disable_float_background = true, -- Transparansi untuk floating windows
				styles = { italic = false },
				highlight_groups = {
					TelescopeNormal = { bg = "NONE" },
					TelescopePromptNormal = { bg = "NONE" },
					TelescopeResultsNormal = { bg = "NONE" },
					TelescopePreviewNormal = { bg = "NONE" },
					TelescopeBorder = { bg = "NONE" },
					TelescopePromptBorder = { bg = "NONE" },
					TelescopeResultsBorder = { bg = "NONE" },
					TelescopePreviewBorder = { bg = "NONE" },
					NormalNC = { bg = "NONE" },
					BufferTabpageFill = { bg = "NONE" },
					BufferCurrent = { bg = "NONE", fg = "text", bold = true },
					BufferVisible = { bg = "NONE", fg = "subtle" },
					BufferInactive = { bg = "NONE", fg = "#aaaaaa" }, -- Kontras lebih terang
					BufferInactiveSign = { bg = "NONE", fg = "#aaaaaa" },
					BufferInactiveMod = { bg = "NONE", fg = "#aaaaaa", italic = true },
					BufferTabpages = { bg = "NONE" },
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"svelte",
					"xml",
					"javascriptreact",
					"typescriptreact",
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		config = function()
			local highlight = {
				"IndentLevel1",
				"IndentLevel2",
				"IndentLevel3",
				"IndentLevel4",
			}
			local hooks = require("ibl.hooks")
			-- Buat highlight grup
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IndentLevel1", { fg = "#31748f" }) -- pine
				vim.api.nvim_set_hl(0, "IndentLevel2", { fg = "#56949f" }) -- foam
				vim.api.nvim_set_hl(0, "IndentLevel3", { fg = "#9ccfd8" }) -- iris
				vim.api.nvim_set_hl(0, "IndentLevel4", { fg = "#f6c177" }) -- gold
			end)
			require("ibl").setup({
				indent = {
					char = "│",
					highlight = highlight,
				},
				scope = { enabled = false }, -- Nonaktifkan scope untuk performa
			})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "http")
			end,
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "InsertEnter",
		config = true,
	},
	{ "echasnovski/mini.surround", event = "InsertEnter", version = "*" },
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},
	-- Enhanced UI for vim.ui.select and vim.ui.input
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				enabled = true,
				default_prompt = "➤ ",
				title_pos = "center",
				insert_only = true,
				start_in_insert = true,
				border = "rounded",
				relative = "cursor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				buf_options = {},
				win_options = {
					winblend = 10,
					winhighlight = "Normal:Normal,NormalNC:Normal",
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
			},
			select = {
				enabled = true,
				backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
				telescope = require("telescope.themes").get_cursor({
					layout_config = {
						width = 80,
						height = 15,
					},
				}),
				fzf = {
					window = {
						width = 0.5,
						height = 0.4,
					},
				},
				fzf_lua = {},
				nui = {
					position = "50%",
					size = nil,
					relative = "editor",
				},
				builtin = {
					border = "rounded",
					relative = "editor",
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "classic",
			delay = 200,
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
				title = true,
				title_pos = "center",
			},
			layout = {
				width = { min = 20 },
				spacing = 3,
			},
			show_help = true,
			show_keys = true,
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
