--
-- ░█▀█░█░█░█▀▀░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█▀█░█░█░█░█░█▀▄░█░█░█░█░█▀▀░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

local autocmd
local augroup

autocmd = vim.api.nvim_create_autocmd
augroup = vim.api.nvim_create_augroup('augroup', {clear = true})

autocmd('BufReadPost', {
    pattern = '*',
    group = augroup,
    desc = 'Jump to the last cursor position.',
    command = 'normal! g`\"'
})

autocmd('VimLeave', {
    pattern = '*.tex',
    group = augroup,
    desc = '',
    command = '! ${HOME}/.local/bin/removeTexDependencies'
})

autocmd('TermOpen', {
    pattern = 'term://*',
    group = augroup,
    desc = 'Open built-in terminal in insert mode.',
    command = 'startinsert'
})
