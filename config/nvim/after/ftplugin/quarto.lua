-- WARN: DO NOT CHANGE OR DELETE THIS FILE
-- Handles syntax highlighting more gracefully in quarto files.

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.qmd",
  desc = "Filetype is set to 'markdown'",
  command = "se ft=markdown"
})
