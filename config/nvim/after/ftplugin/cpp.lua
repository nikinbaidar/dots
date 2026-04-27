--
-- ░█▀▀░█▀█░█▀█░░░░█░░░█░█░█▀█
-- ░█░░░█▀▀░█▀▀░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░░░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

function RunCpp()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('! g++ -o /tmp/a.out % && /tmp/a.out ')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.cpp',
    command = 'nnoremap <leader>r :lua RunCpp()<CR>'
})
