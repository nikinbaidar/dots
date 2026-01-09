local autocmd

autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup('OnExit', {clear = true})
vim.api.nvim_create_augroup('AutoSource', {clear = true})

autocmd('BufWritePost', {
    pattern = { "init.lua", "options.lua", "colors.lua", "keymaps.lua", "augroup.lua",
"cmp.lua"},
    group = 'AutoSource',
    desc = 'Automatically source this file after saving',
    command = 'so'
}) 

autocmd('VimLeave', {
    pattern = '*.*',
    group = 'OnExit',
    desc = 'Echo nothing on exit',
    command = 'echo ""'
})

autocmd('VimLeave', {
    pattern = '*.tex',
    group = 'OnExit',
    desc = 'Removes auxillary tex files on exit',
    command = '! ${HOME}/.local/bin/removeTexDependencies'
})

autocmd('TermOpen', {
    pattern = 'term://*',
    desc = 'Open built-in terminal in insert mode.',
    command = 'startinsert'
})



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
