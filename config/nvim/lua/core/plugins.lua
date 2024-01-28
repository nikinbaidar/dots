--
-- ░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█░█▀▀░░░░█░░░█░█░█▀█
-- ░█▀▀░█░░░█░█░█░█░░█░░█░█░▀▀█░░░░█░░░█░█░█▀█
-- ░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-context',
    'JoosepAlviste/nvim-ts-context-commentstring' ,
    'lukas-reineke/indent-blankline.nvim', 
    'nvim-tree/nvim-web-devicons',
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            vim.cmd("set noshowmode")
        end
    }, 
    'numToStr/Comment.nvim',
    'windwp/nvim-autopairs',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-repeat',
    'tpope/vim-fugitive',
    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp"
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            "nikinbaidar/vim-dadbod"
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            'saadparwaiz1/cmp_luasnip'
        },
    },
})
