function RunBash()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term bash %')
end

vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'sh',
    command = 'nnoremap <leader>r :lua RunBash()<CR>'
})
