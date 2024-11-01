--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░▀▀▀░▀▀▀░▀░▀

-- Functions defs need to global

function showTags()
    local escaped_filename = vim.fn.shellescape(vim.fn.expand('%'))
    vim.api.nvim_command('silent ! ctags -R ' .. escaped_filename)
    vim.api.nvim_command('Fz tags')
end

function vim.find_files_from_project_git_root()
    -- If not a git repo looks in current dir only.
    local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
    end
    local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, "<cmd>h")
    end
    if is_git_repo() then
        local opts = {}
        opts = {
            cwd = get_git_root(),
        }
    end
end

vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>DBUIToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>W', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader> ', '<cmd>set spell!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua showTags()<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.keymap.set('n', '<leader>x', "<cmd> DBUIToggle<CR>", {})
vim.keymap.set('n', '<leader>/', "<cmd> FzfLua blines<CR>", {})
vim.keymap.set('n', '<leader>l', "<cmd> FzfLua live_grep<CR>", {})
vim.keymap.set('n', '<leader>b', "<cmd> FzfLua buffers<CR>", {})
-- vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.api.nvim_set_keymap('n', '<leader>.', '<cmd>lua vim.find_files_from_project_git_root()<CR>', {noremap = true})

vim.cmd([[
  command! -range=% FixMultipleSpaces <cmd><line1>,<line2>s/\s\+/ /g
]])


vim.keymap.set('n', "<leader>ff", "<cmd>FzfLua files cwd=~/<CR>", {})
vim.keymap.set('n', "gp", "<cmd>lua require('fzf-lua').grep_project()<CR>", {})
