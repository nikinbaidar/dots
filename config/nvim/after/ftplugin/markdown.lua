--
-- ░█▄█░█▀█░█▀▄░█░█░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█░█░█▀█░█▀▄░█▀▄░█░█░█░█░█▄█░█░█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.wo.conceallevel = 3

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
syntax on
setlocal spell
setlocal spellcapcheck=\_[\])'"   ]\+
setlocal complete+=kspell

command! ViewImage execute('normal! yi):silent ! pqiv " &<CR>')
command! MakeJump execute('update! | normal! vi[yvi(gf/# "<CR>zt0')

syntax region ConcealedCode matchgroup=ConcealGroup start=/`/ end=/`/ concealends contains=ConcealCheck

syntax region ConcealBlockCode start=/```/ end=/```/ concealends

syntax region MyBlock start=/^\s*>/ end=/^\s*$/

]]

