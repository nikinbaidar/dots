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
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'JoosepAlviste/nvim-ts-context-commentstring' 
    use ({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
    use {'hrsh7th/nvim-cmp', requires = { 'saadparwaiz1/cmp_luasnip' }}
end)
