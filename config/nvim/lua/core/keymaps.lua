--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░▀▀▀░▀▀▀░▀░▀

local telescope 
local api
local set

api = vim.api
keymap = vim.keymap

showTags = function()
    vim.api.nvim_command('! ctags -R %')
    vim.api.nvim_command('Telescope current_buffer_tags')
end

vim.g.mapleader = " " 

api.nvim_set_keymap('n', '<leader>d', ':ls<CR>:bd<C-b>', { noremap = true })
api.nvim_set_keymap('n', '<leader>s', ':Buffers<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>j', '<C-w>w', { noremap = true })
api.nvim_set_keymap('n', '<leader>k', '<C-w>W', { noremap = true }) 
api.nvim_set_keymap('n', '<leader> ', ':set spell!<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>t', ':lua showTags()<CR>', {noremap = true})
api.nvim_set_keymap('!', '<C-d>', '<Del>', { noremap = true })
api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

api.nvim_create_user_command(
  'MakeTitleCase',
  function()
    api.nvim_command("normal! i\")
    api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
    api.nvim_command("normal! kJ")
  end,
  {bang = true, desc="Titlecase from current point to EOL"}
)


telescope = require('telescope.builtin')

keymap.set('n', '<leader>g', telescope.current_buffer_fuzzy_find, {})
keymap.set('n', '<leader>s', telescope.buffers, {})
keymap.set('n', '<leader>f', telescope.find_files, {})


