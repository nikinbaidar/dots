-- See [documentation](https://neovim.io/doc/user/pack/#vim.pack)
--
local gh = function(x) return 'https://github.com/' .. x end

-- TODO: Migrate the following plugsin as well?
--     * [ ] 'nikinbaidar/vim-dadbod',
--     * [ ] 'kristijanhusak/vim-dadbod-ui',
--     * [  ]Do TreeSitter all over with the native LSP in mind
--     -- {'hrsh7th/nvim-cmp', dependencies={ 'hrsh7th/cmp-buffer', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp' }},
-- })

vim.pack.add({
    gh('tpope/vim-repeat'),
    gh('Shatur/neovim-ayu'),
    gh('mason-org/mason.nvim'),
    gh('folke/todo-comments.nvim'),
    gh('nvim-lua/plenary.nvim'),
    gh('ibhagwan/fzf-lua'),
    gh('L3MON4D3/LuaSnip'),
    gh('nvim-mini/mini.pairs'),
    gh('lukas-reineke/indent-blankline.nvim'),
    { src = gh('kylechui/nvim-surround'), version = vim.version.range("4.x") },
})

-- NOTE: 
-- * Execute `vim.pack.update()` to update all plugins with new changes.
-- * Execute `vim.pack.del({"vim-surround"})` to delete an installed package.
-- * If the setup of any of the above plugins include more than one line, then place
--   them inside `/after/plugin` otherwise place them below.

vim.cmd.colorscheme("ayu-dark")
require("mason").setup()
require("mini.pairs").setup()
require("todo-comments").setup({signs=false})
require("ibl").setup({scope={enabled=false}})

-- WARN:
-- If you want to use regex transformations in LuaSnip snippets, you need to
-- build the `jsregexp` manually since vim.pack does not seem to provde a build
-- command.
-- TODO:
-- ```bash
-- cd /home/nikin/.local/share/nvim/site/pack/core/opt/LuaSnip
-- make jsregexp
-- ```
--
