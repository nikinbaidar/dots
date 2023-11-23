--
-- ░▀█▀░█▀▀░█░█░░░░█░░░█░█░█▀█
-- ░░█░░█▀▀░▄▀▄░░░░█░░░█░█░█▀█
-- ░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀


vim.api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.b.spell = false

vim.keymap.set('n', '<leader>v',  
function()
    local filepath = vim.fn.expand('%:r') .. ".pdf"
    vim.api.nvim_command("silent ! maggie " .. filepath)
end
)

vim.api.nvim_create_user_command(
  'AddBibliography',
  function()
    vim.api.nvim_command("! clear ; biber %:r")
    vim.api.nvim_command("silent call RunLatex()")
  end, 
  {bang = true, desc = "Add bibliography to tex docs"}
)

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.tex',
    command = 'nnoremap <leader>r :call RunLatex()<CR>'
})

-- Get current cursor position
-- local r,c = unpack(vim.api.nvim_win_get_cursor(0))
