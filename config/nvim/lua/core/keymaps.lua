--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░▀▀▀░▀▀▀░▀░▀

map = vim.api.nvim_set_keymap

vim.g.mapleader = " " 
map('n', '<leader>d', ':ls<CR>:bd<C-b>'   , { noremap = true })
map('n', '<leader>s', ':Buffers<CR>' , { noremap = true })
map('n', '<leader>j', '<C-w>w'       , { noremap = true })
map('n', '<leader>k', '<C-w>W'       , { noremap = true }) 
map('!', '<C-d>'    , '<Del>'        , { noremap = true })
map('n', '<leader> ', ':set spell!<CR>', { noremap = true })
map('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})
map('n', '<leader>t', ':lua ShowTags()<CR>', {})

vim.api.nvim_create_user_command(
  'MakeTitleCase',
  function()
    vim.api.nvim_command("normal! i\")
    vim.api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
    vim.api.nvim_command("normal! kJ")
  end,
  {bang = true, desc="Titlecase from current point to EOL"}
)

local telescope = require('telescope.builtin')

function ShowTags()
    vim.api.nvim_command('! ctags -R %')
    vim.api.nvim_command('Telescope current_buffer_tags')
end

vim.keymap.set('n', '<leader>g', telescope.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>s', telescope.buffers, {})
vim.keymap.set('n', '<leader>f', telescope.find_files, {})


