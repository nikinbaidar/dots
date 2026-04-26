--
-- ░█▀▀░█▀█░░░░█░░░█░█░█▀█
-- ░█░█░█░█░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

function RunGo()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('! go run %')
end

api.nvim_create_autocmd('BufEnter', {
    pattern = '*.go',
    command = 'nnoremap <leader>r :lua RunGo()<CR>'
})
