-- ╔╦╗┬─┐┌─┐┌─┐┌─┐┬┌┬┐┌┬┐┌─┐┬─┐
--  ║ ├┬┘├┤ ├┤ └─┐│ │  │ ├┤ ├┬┘
--  ╩ ┴└─└─┘└─┘└─┘┴ ┴  ┴ └─┘┴└─

require 'nvim-treesitter.configs'.setup { 
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        -- disable = { "markdown" } 
    },

    context = {
        enable = true
    },

    incremental_selection = { 
        enable = true 
    },

    indent = {
        enable = false 
    },

    contex_commentstring = {
        enable = true
    },
} 

