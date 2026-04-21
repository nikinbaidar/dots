local gh = function(plugin) return 'https://github.com/' .. plugin end

vim.pack.add({
    gh('rebelot/kanagawa.nvim'),
    gh('tpope/vim-surround'),
    gh('tpope/vim-repeat'),
    gh('nikinbaidar/vim-dadbod'),
    gh('L3MON4D3/LuaSnip'),
    gh('windwp/nvim-autopairs'),
    gh('ibhagwan/fzf-lua'),
    gh('nvim-treesitter/nvim-treesitter'),
    gh('JoosepAlviste/nvim-ts-context-commentstring'),
    gh('folke/todo-comments.nvim'),
    gh('nvim-lua/plenary.nvim'),
    gh('lukas-reineke/indent-blankline.nvim'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/cmp-buffer'),
    gh('saadparwaiz1/cmp_luasnip'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh("nvim-tree/nvim-tree.lua"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason.nvim"),
})
