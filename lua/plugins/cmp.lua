-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
--
-- require("luasnip.loaders.from_vscode").lazy_load()
--
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			luasnip.lsp_expand(args.body)
-- 		end,
-- 	},
--
-- 	mapping = {
-- 		["<C-n>"] = cmp.mapping.select_next_item(),
-- 		["<C-k>"] = cmp.mapping.select_prev_item(),
-- 		["<C-l>"] = cmp.mapping.confirm({ select = true }),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 		["<C-e>"] = cmp.mapping.abort(),
-- 	},
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 		{ name = "buffer", max_item_count = 5 },
-- 		{ name = "path" },
-- 	},
-- 	window = {
-- 		completion = cmp.config.window.bordered(),
-- 		documentation = cmp.config.window.bordered(),
-- 	},
-- 	formatting = {
-- 		fields = { "abbr", "kind", "menu" },
-- 		format = function(entry, vim_item)
-- 			vim_item.menu = ({
-- 				nvim_lsp = "[LSP]",
-- 				buffer = "[Buffer]",
-- 				path = "[Path]",
-- 			})[entry.source.name]
-- 			return vim_item
-- 		end,
-- 	},
-- })

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Memuat snippet dari format VS Code secara lazy
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		-- Fungsi expand untuk Luasnip
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = {
		-- Pemetaan Anda yang sudah ada
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-l>"] = cmp.mapping.confirm({ select = true }), -- <C-l> untuk mengonfirmasi
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),

		-- Pemetaan <Tab> yang kondisional
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Pemetaan <S-Tab> (Shift-Tab) yang kondisional
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	-- --- AKHIR PERBAIKAN ---

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer", max_item_count = 5 },
		{ name = "path" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
})
