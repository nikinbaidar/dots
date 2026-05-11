vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', '<leader>R', ':restart<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>W', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>z', '[s1z=', { noremap = true })
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
    { desc = "Make title case from the current cursor position to EOL."}
)

vim.keymap.set('i', '<C-s>', function()
    require('fzf-lua').fzf_exec('cat /home/nikin/notes/tags.txt', {
        winopts = {
            height = 20,
            width = 80,
        },
        actions = {
            ['default'] = function(selected)
                vim.schedule(function()
                    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { selected[1] })
                end)
            end
        }
    })
end, { desc = "Pick and insert tag at cursor" })

-- so ~/.config/nvim/after/plugin/luasnip.lua
