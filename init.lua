local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
