local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")
-- Wrap lines at the terminal window boundary
vim.opt.wrap = true

-- Prevent breaking words in half
vim.opt.linebreak = true

-- Keep indentation on wrapped lines
vim.opt.breakindent = true
-- Compatibility shim: ft_to_lang dihapus di Neovim 0.10+
if vim.fn.has("nvim-0.10") == 1 and not vim.treesitter.ft_to_lang then
	vim.treesitter.ft_to_lang = function(ft)
		local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
		return ok and lang or ft
	end
end
vim.opt.updatetime = 300
-- vim.opt.fileformats = { "unix", "dos", "mac" }
-- Shim vim.diff untuk kompatibilitas
if vim.diff == nil then
	vim.diff = function(a, b, opts)
		return vim.fn.diff(a, b)
	end
end
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		return
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

vim.g.maplocalleader = ","

require("core")

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("lazy").setup({
	{ import = "plugins.init" },
}, {
	checker = {
		enabled = true,
		frequency = 86400,
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	performance = {
		rtp = {
			reset = false, -- Fix for neovim/neovim#29680
		},
	},
})

local ok, _ = pcall(require, "theme")
if not ok then
	vim.notify("No custom theme found, using slate", vim.log.levels.INFO)
	vim.cmd.colorscheme("slate") -- Fallback ke desert
end

require("plugins.statusline")
