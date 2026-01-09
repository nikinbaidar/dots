require("fzf-lua").setup {
    file_icon_padding = ' ',
}

vim.api.nvim_set_keymap('n', '<leader>f', ':FzfLua<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua files cwd="$HOME"<CR>', { noremap = true })

