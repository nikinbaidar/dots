vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {
        "init.lua",
        "options.lua",
        "colors.lua",
        "keymaps.lua", "augroup.lua",
        "cmp.lua",
    },
    desc = "Automatically source this file after saving",
    command = "so"
}) 

vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*.*',
    desc = 'Echo nothing on exit',
    command = 'echo ""'
})

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    desc = 'Open built-in terminal in insert mode.',
    command = 'startinsert'
})

vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*.tex',
    desc = 'Removes auxillary tex files on exit',
    command = '! ${HOME}/.local/bin/removeTexDependencies'
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
