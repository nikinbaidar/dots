-- 
-- ░█▀█░█░█░█▀▀░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█▀█░█░█░█░█░█▀▄░█░█░█░█░█▀▀░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

local autocmd
local augroup

autocmd = vim.api.nvim_create_autocmd
augroup = vim.api.nvim_create_augroup('augroup', {clear = true})

autocmd('BufWritePost', {
    pattern = 'augroup.lua',
    group = augroup,
    desc = 'Automatically source this file after saving',
    command = 'so'
}) 

autocmd('BufReadPost', {
    pattern = '*.md, *.tex',
    group = augroup,
    desc = 'Fixes markdown and tex syntax breaking',
    command = 'syntax sync fromstart'
})

autocmd('BufWrite', {
    pattern = '*.tex',
    group = augroup,
    desc = '',
    command = 'try | %s/\\v(^|\\s|footnote\\{)(|[{[(]|)"/\\1\\2``/g | catch | endtry'
}) 

autocmd('BufWrite', {
    pattern = '*.tex',
    group = augroup,
    desc = '',
    command = 'try | %s/\\v(^|\\s|footnote\\{)(|[{[(]|)\'/\\1\\2`/g | catch | endtry'
}) 

autocmd('BufReadPost', {
    pattern = '*.log',
    group = augroup,
    desc = 'Do not wrap long lines',
    command = 'setlocal nowrap'
})

autocmd('VimLeave', {
    pattern = '*.tex',
    group = augroup,
    desc = '',
    command = '! ${HOME}/.local/bin/removeTexDependencies'
})

autocmd('VimLeave', {
    pattern = '*',
    group = augroup,
    desc = 'Echo nothing, so gibberish don\'t print on a linux terminal',
    command = 'echo ""'
})

autocmd('TermOpen', {
    pattern = 'term://*',
    group = augroup,
    desc = 'Open built-in terminal in insert mode.',
    command = 'startinsert'
})

vim.cmd(' autocmd User DBUIOpened setlocal number relativenumber ')

vim.cmd[[
if has('autocmd')
  " Save and restore cursor position
  augroup remember_cursor
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute("normal! g'\"") | endif
    autocmd VimLeave * if expand('%') != '' | execute "normal! m\"" | wviminfo! | endif
  augroup END
endif
]]
