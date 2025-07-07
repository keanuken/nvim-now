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
		keys = {
			{
				"<leader>ff",
				function()
					local current_file = vim.api.nvim_buf_get_name(0)
					local current_dir

					if current_file and current_file ~= "" then
						current_dir = vim.fn.fnamemodify(current_file, ":h")
					end
					if current_dir and current_dir ~= "" then
						require("telescope.builtin").find_files({
							cwd = current_dir,
						})
					else
						require("telescope.builtin").find_files()
						vim.notify(
							"Could not determine current buffer's directory, falling back to globalm find_files.",
							vim.log.levels.INFO
						)
					end
				end,
				desc = "Telescope: Files (Buffer Dir)",
			},
			{ "<leader>gg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fo", "<cmd>Telescope buffers<cr>", desc = "Open Buffers" },
			{
				"<leader>th",
				function()
					local telescope_custom = require("plugins.telescope") -- Muat modul kustom Anda
					require("telescope.builtin").colorscheme({
						attach_mappings = function(prompt_bufnr, map_func)
							-- Gunakan fungsi dari modul kustom Anda
							map_func("i", "<CR>", telescope_custom.colorscheme_with_save)
							map_func("n", "<CR>", telescope_custom.colorscheme_with_save)
							return true
						end,
					})
				end,
				desc = "Colorscheme Picker",
			},
		},
	},

	-- Oil: File explorer ringan
	{
		"stevearc/oil.nvim",
		keys = { { "-", mode = "n", desc = "Open Oil" } },
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
			{ "<leader>xx", "<cmd>Telescope diagnostics<cr>", desc = "Toggle Diagnostics" },
			{ "<leader>xX", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
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
}
