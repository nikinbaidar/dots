--
-- ░█▀█░█░█░█▀▀░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█▀█░█░█░█░█░█▀▄░█░█░█░█░█▀▀░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

local autocmd
local augroup

autocmd = vim.api.nvim_create_autocmd
augroup = vim.api.nvim_create_augroup('augroup', {clear = true})

-- autocmd('BufReadPost', {
--     pattern = '*',
--     group = augroup,
--     desc = 'Jump to the last cursor position.',
--     command = 'normal! g`\"'
-- })

autocmd('VimLeave', {
    pattern = '*.tex',
    group = augroup,
    desc = '',
    command = '! ${HOME}/.local/bin/removeTexDependencies'
})

autocmd('VimLeave', {
    pattern = '*',
    group = augroup,
    desc = 'Echo nothing so gibberish don\'t print on linux terminal.',
    command = 'echo ""'
})


autocmd('TermOpen', {
    pattern = 'term://*',
    group = augroup,
    desc = 'Open built-in terminal in insert mode.',
    command = 'startinsert'
})

vim.cmd(' autocmd User DBUIOpened setlocal number relativenumber ')

