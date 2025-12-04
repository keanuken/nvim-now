-- disable auto comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Set nohidden to prevent hidden buffers accumulation
vim.cmd([[autocmd VimEnter * set nohidden]])