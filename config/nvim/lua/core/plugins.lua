--
-- ░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█░█▀▀░░░░█░░░█░█░█▀█
-- ░█▀▀░█░░░█░█░█░█░░█░░█░█░▀▀█░░░░█░░░█░█░█▀█
-- ░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'numToStr/Comment.nvim'
    use 'windwp/nvim-autopairs'
    use 'junegunn/fzf.vim'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'JoosepAlviste/nvim-ts-context-commentstring' 

    use {
        'hrsh7th/nvim-cmp',
        requires = { 'saadparwaiz1/cmp_luasnip' }
    }

    use { "L3MON4D3/LuaSnip", after = 'nvim-cmp',
        tag = "v<CurrentMajor>.*"
    }


    use {
        'nvim-lualine/lualine.nvim'
    }
end)
