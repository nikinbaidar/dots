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

vim.api.nvim_create_user_command(
  'MakeTitleCase',
  function()
    vim.api.nvim_command("normal! i\")
    vim.api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
    vim.api.nvim_command("normal! kJ")
  end,
  {bang = true, desc="Titlecase from current point to EOL"}
)

