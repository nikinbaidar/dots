--
-- ░█▄█░█▀█░█▀▄░█░█░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█░█░█▀█░█▀▄░█▀▄░█░█░█░█░█▄█░█░█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.api.nvim_set_keymap('i', '<C-l>', '<C-[>[s1z=`]a', {noremap = true})

vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*.md',
    command = 'silent! execute "syntax sync fromstart"'
})

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
setlocal spellcapcheck=\_[\])'"   ]\+
setlocal complete+=kspell
command! MakeJump execute('update! | normal! vi[yvi(gf/# "<CR>zt0')
nnoremap <leader>f :MakeJump<CR>
]]

luasnippets(nil, { markdown = { 
    snippet({ trig = "sec" }, {
        tx_node("# ", {}),
        in_node(1)
    }), 
}, })
