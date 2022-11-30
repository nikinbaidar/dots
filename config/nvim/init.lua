require("plugins")
require("augroup")

vim.opt.hlsearch       = false
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.ignorecase     = true
vim.opt.autochdir      = true
vim.opt.expandtab      = true
vim.opt.breakindent    = true
vim.opt.linebreak      = true
vim.opt.scrolloff      = 5
vim.opt.shiftwidth     = 4
vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.textwidth      = 79
vim.opt.colorcolumn    = "80"
vim.opt.path           = "./*,**"
vim.opt.tags           = "./.tags"

map = vim.api.nvim_set_keymap
noremap = { noremap = true }

vim.g.mapleader = " " 
map('n', '<leader>d', ':ls<CR>:bd', noremap)
map('n', '<leader>s', ':ls<CR>:b' , noremap)
map('n', '<leader>h', ':bp<CR>'   , noremap)
map('n', '<leader>j', '<C-w>w'    , noremap)
map('n', '<leader>k', '<C-w>w'    , noremap) 
map('n', '<leader>l', ':bn<CR>'   , noremap)
map('!', '<C-d>'    , '<Del>'     , noremap)
