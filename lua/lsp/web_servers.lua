--- Web Development LSP Configurations
--- @brief
---
--- Configurations for HTML, CSS, and Prisma LSP servers

local M = {}

-- HTML LSP Configuration
M.html = {
  cmd = { 'vscode-html-language-server', '--stdio' },

  filetypes = {
    'html',
    'templ',
  },

  root_dir = function(fname)
    local root_markers = {
      'package.json',
      '.git',
    }

    local bufnr = vim.api.nvim_get_current_buf()
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    return project_root
  end,

  on_attach = function(client, bufnr)
    vim.notify('LSP HTML attached', vim.log.levels.INFO)
    -- Keymap untuk LSP
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}

-- CSS LSP Configuration
M.cssls = {
  cmd = { 'vscode-css-language-server', '--stdio' },

  filetypes = {
    'css',
    'scss',
    'less',
  },

  root_dir = function(fname)
    local root_markers = {
      'package.json',
      '.git',
    }

    local bufnr = vim.api.nvim_get_current_buf()
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    return project_root
  end,

  on_attach = function(client, bufnr)
    vim.notify('LSP CSS attached', vim.log.levels.INFO)
    -- Keymap untuk LSP
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
}

-- Prisma LSP Configuration
M.prismals = {
  cmd = { 'prisma-language-server', '--stdio' },

  filetypes = {
    'prisma',
  },

  root_dir = function(fname)
    local root_markers = {
      'package.json',
      '.git',
    }

    local bufnr = vim.api.nvim_get_current_buf()
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    return project_root
  end,

  on_attach = function(client, bufnr)
    vim.notify('LSP Prisma attached', vim.log.levels.INFO)
    -- Keymap untuk LSP
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  settings = {
    prisma = {
      prismaFmtBinPath = '',
    },
  },
}

return M
