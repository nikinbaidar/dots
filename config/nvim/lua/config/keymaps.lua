vim.g.mapleader = ","

vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', { desc="Delete", noremap=true })
vim.api.nvim_set_keymap('!', '<C-h>', '<BS>', { desc="Backspace", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>W', { desc="Previous window", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>w', { desc="Next window", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>p', ':bp<CR>', { desc="Previous buffer", noremap=true })
vim.api.nvim_set_keymap('n', '<leader>n', ':bn<CR>', { desc="Next buffer", noremap=true })
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>mx[s1z=`xA', { desc="Correct previous misspelled word" })

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

command! CopyWorkingDir let @+ = getcwd()
command! -nargs=* -range -register CopyMatches call CopyMatches(<q-reg>, <line1>, <line2>)
]]

-- WARN: DO NOT RUN `FixFormatting` on this file.
vim.api.nvim_create_user_command(
    "FixFormatting",
    function()
        vim.api.nvim_command('normal! mz')
        vim.api.nvim_command("silent! %s/[“”]/\"/g")
        vim.api.nvim_command("silent! %s/[‘’]/\'/g")
        vim.cmd([[
            silent! %s/\(^\s*\)\@<! \+\(\s*$\)\@!/ /g
            silent! %s/\s\+$//g
            silent! %s/[\x00-\x08\x0B-\x0C\x0E-\x1F\x7F]//g
        ]])
        vim.api.nvim_command('normal! `z')
    end,
    { desc = "Fix formatting: Replace funny quotes, collapse spaces while preserving indentations, remove trailing whitespace and unwanted ASCII control characters from the entire file." }
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
