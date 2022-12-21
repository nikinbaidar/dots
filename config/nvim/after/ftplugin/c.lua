--
-- ░█▀▀░░░░█░░░█░█░█▀█
-- ░█░░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

function RunC()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term gcc -o /tmp/w % && /tmp/w ')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.c',
    command = 'nnoremap <leader>r :lua RunC()<CR>'
})
