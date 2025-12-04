--- Lua LSP Configuration
--- @brief
---
--- Configuration for lua-language-server
--- Provides comprehensive Lua support with EmmyLua annotations

---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },

  filetypes = {
    'lua',
  },

  root_dir = function(fname)
    local root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      '.git',
    }

    local bufnr = vim.api.nvim_get_current_buf()
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    return project_root
  end,

  on_attach = function(client, bufnr)
    vim.notify('LSP lua_ls attached', vim.log.levels.INFO)
    -- Keymap untuk LSP
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,

  capabilities = require('cmp_nvim_lsp').default_capabilities(),

  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.stdpath('config') .. '/lua',
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
