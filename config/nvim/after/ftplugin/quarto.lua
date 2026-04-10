-- WARN: DO NOT CHANGE OR DELETE THIS FILE
-- Handles syntax highlighting more gracefully in quarto files.

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.qmd",
  desc = "Filetype is set to 'markdown'",
  command = "se ft=markdown"
})

function CompileQuarto()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('silent ! quarto render % --to html')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.qmd',
    command = 'nnoremap <leader>r :lua CompileQuarto()<CR>'
})

vim.opt.spell = true
