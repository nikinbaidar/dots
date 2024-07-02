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
    -- 'numToStr/Comment.nvim',
    'windwp/nvim-autopairs',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    -- 'tpope/vim-fugitive',
    {
        'ibhagwan/fzf-lua',
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
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
})
