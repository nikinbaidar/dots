-- WARN: DO NOT CHANGE OR DELETE THIS FILE
-- Handles plaintex more gracefully -> renders colors inits tex related stuff.

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = 'tex',
    command = 'nnoremap <leader>r :call RunLatex()<CR>'
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.tex",
  desc = "Filetype is set to 'tex' and  after saving a .tex file",
  command = "se ft=tex"
})
