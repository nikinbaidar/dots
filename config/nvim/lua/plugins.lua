local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath, 
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'rebelot/kanagawa.nvim',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    "nvim-tree/nvim-web-devicons",
    "ibhagwan/fzf-lua",
    'hrsh7th/nvim-cmp',
    'nvim-treesitter/nvim-treesitter',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'lukas-reineke/indent-blankline.nvim', 
    'saadparwaiz1/cmp_luasnip',
    { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
})
