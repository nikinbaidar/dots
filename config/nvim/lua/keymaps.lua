vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>W', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', { noremap = true })

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
command! ReloadNvim source $MYVIMRC
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
    {desc = "Replaces funny quotes with proper ones."}
)

vim.api.nvim_create_user_command(
    "StripTrailingSpaces",
    function()
        if vim.bo.filetype == "markdown" then
            vim.api.nvim_command("silent! %s/\\s\\+$/  /g")
        else
            vim.api.nvim_command("silent! %s/\\s\\+$//g")
        end
    end,
    { desc = "Removes trailing spaces in the entire buffer. For makrdown files keeps two trailing spaces."}
)

vim.api.nvim_create_user_command(
    "MakeTitleCase",
    function()
        vim.api.nvim_command("normal! i\")
        vim.api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
        vim.api.nvim_command("normal! kJ")
    end,
    { desc = "Make title case from the current cursor position to EOL."}
)

-- so ~/.config/nvim/after/plugin/luasnip.lua
