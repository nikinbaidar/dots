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
    { 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
    "ibhagwan/fzf-lua",
    'nvim-treesitter/nvim-treesitter',
    'JoosepAlviste/nvim-ts-context-commentstring',
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    'lukas-reineke/indent-blankline.nvim',
    { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
    {'hrsh7th/nvim-cmp', dependencies={ 'hrsh7th/cmp-buffer', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp' }},
    {"nvim-tree/nvim-tree.lua", dependencies={ "nvim-tree/nvim-web-devicons", }},
    {"neovim/nvim-lspconfig", dependencies={ "mason-org/mason.nvim", }},
})
