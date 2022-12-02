-- ╔═╗╔═╗╔═╗
-- ╠╣ ╔═╝╠╣ 
-- ╚  ╚═╝╚  

local parameters = {silent = true, noremap = true}

vim.g.fzf_layout = {
    window = {
        width  = 0.90,
        height = 0.90,
        border = 'sharp'
    }
}
vim.g.fzf_preview_window = {'right,60%,<60(down,60%)', 'ctrl-/'}

vim.api.nvim_set_keymap('n', '<C-t>', ':Files ~/<CR>', parameters)

vim.keymap.set('n', '<leader>t',
function()
    vim.cmd 'update!'
    vim.api.nvim_command("silent ! ctags -f ./.tags --recurse ./")
    vim.api.nvim_command("BTags")
end,
{desc = 'Generate tags for the current project and open them up with fzf.'})
