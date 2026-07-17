-- TODO: Migrate to vim.pack
-- See [documentation](https://neovim.io/doc/user/pack/#vim.pack)
vim.opt.packpath:prepend(vim.fn.stdpath('data') .. '/site')

vim.pack.add({
    "https://github.com/Shatur/neovim-ayu",
    "https://github.com/tpope/vim-surround",
    "https://github.com/tpope/vim-repeat",
})

-- NOTE: The following manually add each plugin loaded by pack.add and is
-- necessary beacuse I am also loading lazy currently. This can be completely
-- disregarded in the future.

vim.cmd.packadd("vim-surround")
vim.cmd.packadd("vim-repeat")
