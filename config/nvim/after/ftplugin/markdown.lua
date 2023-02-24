--
-- ░█▄█░█▀█░█▀▄░█░█░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█░█░█▀█░█▀▄░█▀▄░█░█░█░█░█▄█░█░█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

map('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.wo.conceallevel = 2
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"


vim.api.nvim_create_user_command(
  'Maketitlecase',
  function()
    vim.api.nvim_command("normal! i\")
    vim.api.nvim_command("s#\\v(\\w)(\\s*)#\\u\\1\\l\\2#g")
    vim.api.nvim_command("normal! kj")
  end,
  {bang = true, desc="titlecase from current point to eol"}
)

vim.cmd [[ 
setlocal spell
setlocal spellcapcheck=\_[\])'"   ]\+
setlocal complete+=kspell

command! ViewImage execute('normal! yi):silent ! pqiv " &<CR>')
command! MakeJump execute('update! | normal! vi[yvi(gf/# "<CR>zt0')
nnoremap <leader>f :MakeJump<CR>
]]
