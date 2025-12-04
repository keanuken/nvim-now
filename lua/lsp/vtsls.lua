--- TypeScript/JavaScript LSP Configuration
--- @brief
---
--- Configuration for vtsls (TypeScript Language Server)
--- Provides comprehensive TypeScript and JavaScript support

local util = require('lspconfig.util')

---@type vim.lsp.Config
return {
  cmd = { 'vtsls', '--stdio' },

  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'jsx',
    'tsx',
  },

  root_dir = function(fname)
    -- More robust root detection for JSX/TSX files
    local root_markers = {
      'tsconfig.json',
      'jsconfig.json',
      'package.json',
      'vite.config.ts',
      'vite.config.js',
      'vite.config.mjs',
      'webpack.config.js',
      'webpack.config.ts',
      'next.config.js',
      'nuxt.config.ts',
      '.git',
      'node_modules'  -- Fallback for any Node.js project
    }

    local bufnr = vim.api.nvim_get_current_buf()

    -- First try to find root with primary markers
    local project_root = vim.fs.root(bufnr, root_markers)
    if project_root then
      return project_root
    end

    -- Fallback: try to find any Node.js project root
    local node_root = vim.fs.root(bufnr, {'package.json', 'node_modules'})
    if node_root then
      return node_root
    end

    -- Final fallback: current working directory
    return vim.fn.getcwd()
  end,

  on_attach = function(client, bufnr)
    vim.notify('LSP vtsls attached', vim.log.levels.INFO)
    -- Keymap untuk LSP
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        includeCompletionsForImportStatements = true,
        includeAutomaticOptionalChainCompletions = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        includeCompletionsForImportStatements = true,
        includeAutomaticOptionalChainCompletions = true,
      },
    },
    -- JSX and React specific settings
    jsx_close_tag = {
      enable = true,
    },
    completions = {
      completeFunctionCalls = true,
    },
    -- Enable experimental features for better JSX support
    tsserver = {
      experimental = {
        enableProjectDiagnostics = true,
      },
    },
  },
}
