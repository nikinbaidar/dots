--
-- ░█▀▄░█▀█░█▀▄░█▀▄░█▀█░█▀▄░░░░░█░█░▀█▀
-- ░█░█░█▀█░█░█░█▀▄░█░█░█░█░▄▄▄░█░█░░█░
-- ░▀▀░░▀░▀░▀▀░░▀▀░░▀▀▀░▀▀░░░░░░▀▀▀░▀▀▀

vim.g.db_ui_show_help = 0
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_winwidth = 50

vim.api.nvim_set_keymap('n', '<leader>u', ':DBUIToggle<CR>', { silent = true })
