vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>W', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', { noremap = true })

vim.cmd([[
  command! -range=% FixMultipleSpaces <cmd><line1>,<line2>s/\s\+/ /g
  command! Copypwd let @+ = getcwd()
]])
