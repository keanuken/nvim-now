require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		lua = { "stylua" },
		prisma = { "prisma_fmt" },
		python = { "black" },
	},
	format_on_save = {
		timeout_ms = 2500,
		lsp_fallback = false,
	},
	notify_on_error = true,
})

-- prose wrapper argument for customized prettier
require("conform").formatters.prettier = {
	prepend_args = { "--prose-wrap", "always" },
}

-- Install formatters via mason-tool-installer
require("mason-tool-installer").setup({
	ensure_installed = { "prettier", "stylua" },
	auto_update = true,
	run_on_start = true,
})
