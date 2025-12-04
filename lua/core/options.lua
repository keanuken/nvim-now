local opt = vim.opt

--- ==================== UI & Appearance ====================
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cmdheight = 2
opt.showmode = false
opt.wrap = false

--- ==================== Indentation ====================
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

--- ==================== Performance & Behavior ====================
opt.undofile = true
opt.swapfile = false
opt.hlsearch = true
opt.updatetime = 300
opt.conceallevel = 0
opt.inccommand = "split"
opt.lazyredraw = true

--- ==================== Clipboard (Penting untuk VSCode friendly) ===================
opt.clipboard = "unnamedplus"

--- ==================== Mouse (Penting untuk VSCode friendly) ====================
opt.mouse = "a"

--- ==================== Backspace ====================
opt.backspace = "indent,eol,start"

--- ==================== Split Window Behavior ====================
opt.splitright = true
opt.splitbelow = true

--- ==================== Command Line / Wildmenu ====================
opt.wildmenu = true
opt.wildmode = "list:longest,full"

--- ==================== Search Behavior ====================
opt.ignorecase = true
opt.smartcase = true
--- ==================== Others ====================
opt.joinspaces = false
