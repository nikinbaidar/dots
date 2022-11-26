--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀

map = vim.api.nvim_set_keymap

local parameters = { noremap = true }

vim.g.mapleader = " " 

map('!', '<C-d>'    , '<Del>'     , parameters)
map('n', '<leader>d', ':ls<CR>:bd', parameters)
map('n', '<leader>s', ':ls<CR>:b' , parameters)
map('n', '<leader>h', ':bp<CR>'   , parameters)
map('n', '<leader>j', '<C-w>w'    , parameters)
map('n', '<leader>k', '<C-w>w'    , parameters) 
map('n', '<leader>l', ':bn<CR>'   , parameters)
