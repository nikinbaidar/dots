vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.autochdir = true
vim.opt.laststatus = 0
vim.opt.winbar = "%t"
vim.opt.timeoutlen = 200
vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = true
vim.opt.confirm = false
vim.opt.path:append("**,")
vim.opt.textwidth = 80
vim.opt.formatoptions = "jcrqltn" -- implement this from autocmds
vim.opt.list = true
vim.opt.listchars = "trail:␣"
