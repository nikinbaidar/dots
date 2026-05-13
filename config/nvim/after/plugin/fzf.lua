#!/usr/bin/env lua

require("fzf-lua").setup {
    file_icon_padding = ' ',
    files = {
        hidden = false,
        cwd = vim.env.HOME,
        fd_opts = [[
        --color=never
        --type f
        --follow
        --exclude _site
        --exclude node_modules
        ]],
    },
    buffers = {
        ignore_current_buffer = true,
    },
}

vim.api.nvim_set_keymap('n', '<leader>f', ':FzfLua<CR>', { noremap = true })
