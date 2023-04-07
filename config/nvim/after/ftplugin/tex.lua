--
-- ░▀█▀░█▀▀░█░█░░░░█░░░█░█░█▀█
-- ░░█░░█▀▀░▄▀▄░░░░█░░░█░█░█▀█
-- ░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀


vim.api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.b.cursorcolumn = true
vim.b.spell        = true


vim.keymap.set('n', '<leader>v',  
function()
    local filepath = vim.fn.expand('%:r') .. ".pdf"
    vim.api.nvim_command("silent ! jumanji " .. filepath)
end
)

vim.api.nvim_create_user_command(
  'MakeTitleCase',
  function()
    vim.api.nvim_command("normal! i\")
    vim.api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
    vim.api.nvim_command("normal! kJ")
  end,
  {bang = true, desc="Titlecase from current point to EOL"}
)

vim.api.nvim_create_user_command(
  'AddBibliography',
  function()
    vim.api.nvim_command("! clear ; biber %:r")
    vim.api.nvim_command("silent call CodeRunner()")
  end,
  {bang = true, desc = "Add bibliography to tex docs"}
)

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.tex',
    command = 'nnoremap <leader>r :call RunLatex()<CR>'
})

-- Get current cursor position
-- local r,c = unpack(vim.api.nvim_win_get_cursor(0))
