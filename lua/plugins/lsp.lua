local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Pastikan diagnostics aktif
vim.diagnostic.config({
	virtual_text = false, -- Biarkan tiny-inline-diagnostic menangani inline
	signs = true,
	update_in_insert = false, -- Update diagnostics di mode normal
	severity_sort = true,
})

-- Setup Mason-LSPConfig
mason_lspconfig.setup({
	ensure_installed = { "vtsls", "html", "cssls", "lua_ls", "prismals" }, -- Sesuaikan dengan kebutuhan
	automatic_installation = true,
})

-- Handler untuk setup LSP server
mason_lspconfig.setup({
	handlers = {
		function(server_name)
			lspconfig[server_name].setup({
				on_attach = function(client, bufnr)
					vim.notify("LSP " .. server_name .. " attached", vim.log.levels.INFO)
					-- Keymap untuk LSP
					local opts = { buffer = bufnr, noremap = true, silent = true }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					-- Refresh diagnostics saat buffer dibuka
					vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
						buffer = bufnr,
						callback = function()
							-- Delay kecil untuk pastikan LSP siap
							vim.defer_fn(function()
								vim.diagnostic.show()
							end, 100)
						end,
					})
				end,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
		end,
	},
})
