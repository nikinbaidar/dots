-- ╔╦╗┬─┐┌─┐┌─┐┌─┐┬┌┬┐┌┬┐┌─┐┬─┐
--  ║ ├┬┘├┤ ├┤ └─┐│ │  │ ├┤ ├┬┘
--  ╩ ┴└─└─┘└─┘└─┘┴ ┴  ┴ └─┘┴└─

require 'nvim-treesitter.configs'.setup { 
    highlight = {
        enable = false,
        additional_vim_regex_highlighting = false,
        -- disable = { "markdown" } 
    },

    context = {
        enable = false
    },

    incremental_selection = { 
        enable = false 
    },

    indent = {
        enable = false 
    },

    contex_commentstring = {
        enable = false
    },
} 

