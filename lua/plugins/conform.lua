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
	},
   format_on_save = function(bufnr)
    -- Skip kalau formatter tidak ready
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return {
      timeout_ms = 2500,
      lsp_fallback = false,
    }
  end,
  notify_on_error = false, -- ← matikan dulu untuk debugging
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
