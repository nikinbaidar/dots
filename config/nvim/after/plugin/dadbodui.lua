--
-- ░█▀▄░█▀█░█▀▄░█▀▄░█▀█░█▀▄░░░░░█░█░▀█▀
-- ░█░█░█▀█░█░█░█▀▄░█░█░█░█░▄▄▄░█░█░░█░
-- ░▀▀░░▀░▀░▀▀░░▀▀░░▀▀▀░▀▀░░░░░░▀▀▀░▀▀▀

vim.g.db_ui_show_help = 0
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_win_position = "right"
vim.g.db_ui_save_location = "~/projects/endeavour/sql"


vim.api.nvim_set_keymap('n', '<leader>x', ':DBUIToggle<CR>', {noremap = true})
