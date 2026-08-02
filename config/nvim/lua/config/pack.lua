#!/usr/bin/env lua

-- NOTE: See [documentation](https://neovim.io/doc/user/pack/#vim.pack)

local gh = function(x) return 'https://github.com/' .. x end

-- TODO: Migrate the following plugins as well?
--     * [ ] 'nikinbaidar/vim-dadbod',
--     * [ ] 'kristijanhusak/vim-dadbod-ui',
-- })

vim.pack.add({
    gh('tpope/vim-repeat'),
    gh('nvim-lua/plenary.nvim'),
    gh('Shatur/neovim-ayu'),
    gh('mason-org/mason.nvim'),
    gh('folke/todo-comments.nvim'),
    gh('ibhagwan/fzf-lua'),
    gh('L3MON4D3/LuaSnip'),
    gh('nvim-mini/mini.pairs'),
    gh('nvim-mini/mini.icons'),
    gh('stevearc/oil.nvim'),
    gh('lukas-reineke/indent-blankline.nvim'),
    { src = gh('kylechui/nvim-surround'), version = vim.version.range("4.x") },
    gh('saghen/blink.lib'),
    gh('saghen/blink.cmp'),
    gh('jmbuhr/otter.nvim'),
    gh('nvim-treesitter/nvim-treesitter'),
})

--  NOTE: 
-- * Execute `vim.pack.update()` to update all plugins with new changes.

-- TODO: If the setup of any of the above plugins include more than one line, then
-- place them inside `/config/plugin` otherwise place them directly below.

require("mason").setup()
require("mini.pairs").setup()
require("mini.icons").setup()
require("oil").setup()
require("todo-comments").setup({signs=false})
require("ibl").setup({scope={enabled=false}})
require("plugins.ayu")
require("plugins.luasnip")
require("plugins.blink")
require("plugins.fzf")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.otter")

--  NOTE: On a new system:
--  1. Install `jsregexp` if you want to use regex transformations with LuaSnip.
--  1. Install rust on the host.
--
-- WARN: You need to build the `jsregexp` manually since vim.pack does not to
-- provide a build command.
-- ```bash
-- cd $HOME/.local/share/nvim/site/pack/core/opt/LuaSnip
-- make jsregexp
-- ```
