-- ╔╦╗┬─┐┌─┐┌─┐┌─┐┬┌┬┐┌┬┐┌─┐┬─┐
--  ║ ├┬┘├┤ ├┤ └─┐│ │  │ ├┤ ├┬┘
--  ╩ ┴└─└─┘└─┘└─┘┴ ┴  ┴ └─┘┴└─

require 'nvim-treesitter.configs'.setup { 
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        disable = { "latex" } 
    },
    incremental_selection = { enable = true },
    indent = { enable = false },
} 
