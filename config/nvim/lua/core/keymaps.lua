--
-- ░█░█░█▀▀░█░█░█▄█░█▀█░█▀█░█▀▀░░░█░░░█░█░█▀█
-- ░█▀▄░█▀▀░░█░░█░█░█▀█░█▀▀░▀▀█░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░▀▀▀░▀░▀▀▀░▀▀▀░▀░▀

local builtin = require('telescope.builtin')


-- Functions defs need to global

function showTags()
    vim.api.nvim_command('! ctags -R %')
    vim.api.nvim_command('Telescope current_buffer_tags')
end

function vim.find_files_from_project_git_root()
    -- If not a git repo looks in current dir only.
    local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
    end
    local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
    end
    local opts = {}
    if is_git_repo() then
        opts = {
            cwd = get_git_root(),
        }
    end
    require("telescope.builtin").fd(opts)
end

vim.g.mapleader = " " 

vim.api.nvim_set_keymap('n', '<leader>d', ':ls<CR>:bd<C-b>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>W', { noremap = true }) 
vim.api.nvim_set_keymap('n', '<leader> ', ':set spell!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':lua showTags()<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<C-d>', '<Del>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.api.nvim_create_user_command(
  'MakeTitleCase',
  function()
    api.nvim_command("normal! i\")
    api.nvim_command("s#\\v(\\w)(\\S*)#\\u\\1\\L\\2#g")
    api.nvim_command("normal! kJ")
  end,
  {bang = true, desc="Titlecase from current point to EOL"}
)

vim.keymap.set('n', '<leader>gb', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>gl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.api.nvim_set_keymap('n', '<leader>.', ':lua vim.find_files_from_project_git_root()<CR>', {noremap = true})

