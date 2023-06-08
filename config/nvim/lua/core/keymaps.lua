--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░▀▀▀░▀▀▀░▀░▀

map = vim.api.nvim_set_keymap

vim.g.mapleader = " " 
map('n', '<leader>d', ':ls<CR>:bd'   , { noremap = true })
map('n', '<leader>s', ':Buffers<CR>' , { noremap = true })
map('n', '<leader>j', '<C-w>w'       , { noremap = true })
map('n', '<leader>k', '<C-w>W'       , { noremap = true }) 
map('!', '<C-d>'    , '<Del>'        , { noremap = true })
map('n', '<leader> ', ':set spell!<CR>', { noremap = true })
map('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})
