vim.g.mapleader = ","

vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', { desc="Delete", noremap=true })
vim.api.nvim_set_keymap('!', '<C-h>', '<BS>', { desc="Backspace", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>W', { desc="Previous window", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>w', { desc="Next window", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>p', ':bp<CR>', { desc="Previous buffer", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>n', ':bn<CR>', { desc="Next buffer", noremap=true })
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>mx[s1z=`xa', { desc="Correct previous misspelled word" })

vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]

vim.cmd [[
function! CopyMatches(reg, start, end) range
" Copies all matched patterns of the most recent search.
" `a,bCopyMatches` copies matched patterns from lines a to b.
let hits = []
let reg = empty(a:reg) ? '+' : a:reg
let range = (a:start == a:end) ? '%' : a:start.','.a:end
execute range.'s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne'
execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
]]

vim.cmd([[
command! CopyWorkingDir let @+ = getcwd()
command! -nargs=* -range -register CopyMatches call CopyMatches(<q-reg>, <line1>, <line2>)
]])

vim.api.nvim_create_user_command(
    "FixQuotes",
    function()
        vim.api.nvim_command('normal! mz')
        vim.api.nvim_command("silent! %s/[“”]/\"/g")
        vim.api.nvim_command("silent! %s/[‘’]/\'/g")
        vim.api.nvim_command('normal! `z')
    end,
    { desc = "Replaces funny quotes with proper ones." }
)

vim.api.nvim_create_user_command(
    "TrimSpaces",
    function()
        vim.cmd([[silent! %s/\(^\s*\)\@<! \+\(\s*$\)\@!/ /g]])
        vim.api.nvim_command("silent! %s/\\s\\+$//g")
    end,
    { desc = "Replace consecutive spaces in the entire buffer. Indentations and trailing spaces stay." }
)

vim.api.nvim_create_user_command(
    "MakeTitleCase",
    function()
        vim.api.nvim_command("normal! i\")
        vim.api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
        vim.api.nvim_command("normal! kJ")
    end,
    { desc = "Make title case from the current cursor position to EOL." }
)

-- so ~/.config/nvim/after/plugin/luasnip.lua
