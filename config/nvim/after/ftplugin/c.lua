function RunC()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('! gcc -o /tmp/a.out -lm % && /tmp/a.out ')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.c',
    command = 'nnoremap <leader>r :lua RunC()<CR>'
})
