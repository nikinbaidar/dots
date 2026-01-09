require 'nvim-treesitter'.setup { 
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "markdown", "tex", "plaintex" }
    },

    contex_commentstring = {
        enable = true
    },
} 
