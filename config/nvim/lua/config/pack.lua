-- See [documentation](https://neovim.io/doc/user/pack/#vim.pack)
--
local gh = function(x) return 'https://github.com/' .. x end

-- TODO: Migrate the following plugsin as well?
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
    gh('lukas-reineke/indent-blankline.nvim'),
    { src = gh('kylechui/nvim-surround'), version = vim.version.range("4.x") },
    gh('saghen/blink.lib'),
    gh('saghen/blink.cmp'),
    gh('jmbuhr/otter.nvim'),
    gh('nvim-treesitter/nvim-treesitter'),
})

--  NOTE: 
-- * Execute `vim.pack.update()` to update all plugins with new changes.
-- * Execute `vim.pack.del({"vim-surround"})` to delete an installed package.


-- NOTE: If the setup of any of the above plugins include more than one line, then
-- place them inside `/config/plugin` otherwise place them directly below.

vim.cmd.colorscheme("ayu-dark")
vim.api.nvim_set_hl(0, "LineNr", {fg="gray", bg = "none"})

vim.cmd [[
let g:terminal_color_3 = '#0b0e14'
]]

require("mason").setup()
require("mini.pairs").setup()
require("todo-comments").setup({signs=false})
require("ibl").setup({scope={enabled=false}})

require("plugins.luasnip")
require("plugins.blink")
require("plugins.fzf")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.otter")

-- WARN:
-- If you want to use regex transformations in LuaSnip snippets, you need to
-- build the `jsregexp` manually since vim.pack does not seem to provde a build
-- command.
--
-- TODO:
-- ```bash
-- cd /home/nikin/.local/share/nvim/site/pack/core/opt/LuaSnip
-- make jsregexp
-- ```
