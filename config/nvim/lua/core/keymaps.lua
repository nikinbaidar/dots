--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░▀▀▀░▀▀▀░▀░▀



map = vim.api.nvim_set_keymap

vim.g.mapleader = " " 
map('n', '<leader>d', ':ls<CR>:bd', { noremap = true })
map('n', '<leader>s', ':ls<CR>:b' , { noremap = true })
map('n', '<leader>h', ':bp<CR>'   , { noremap = true })
map('n', '<leader>j', '<C-w>w'    , { noremap = true })
map('n', '<leader>k', '<C-w>w'    , { noremap = true }) 
map('n', '<leader>l', ':bn<CR>'   , { noremap = true })
map('!', '<C-d>'    , '<Del>'     , { noremap = true })

map('n', '<leader> ', ':set spell!<CR>', { noremap = true })
