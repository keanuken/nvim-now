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
		-- Load modular LSP configurations
		vtsls = function()
			local config = require("lsp.vtsls")
			local ok, err = pcall(function()
				lspconfig.vtsls.setup(config)
			end)
			if not ok then
				vim.notify("Failed to setup vtsls LSP: " .. err, vim.log.levels.WARN)
			end
		end,

		eslint = function()
			local config = require("lsp.eslint")
			local ok, err = pcall(function()
				lspconfig.eslint.setup(config)
			end)
			if not ok then
				vim.notify("Failed to setup eslint LSP: " .. err, vim.log.levels.WARN)
			end
		end,

		lua_ls = function()
			local config = require("lsp.lua_ls")
			lspconfig.lua_ls.setup(config)
		end,

		html = function()
			local config = require("lsp.web_servers").html
			lspconfig.html.setup(config)
		end,

		cssls = function()
			local config = require("lsp.web_servers").cssls
			lspconfig.cssls.setup(config)
		end,

		prismals = function()
			local config = require("lsp.web_servers").prismals
			lspconfig.prismals.setup(config)
		end,

		-- Handler default untuk server lainnya
		function(server_name)
			local config = {
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
			}

			lspconfig[server_name].setup(config)
		end,
	},
})
