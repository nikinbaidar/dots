--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█░░░░█░░░█░█░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

local luasnip = require("luasnip")
local filetype_functions = require('luasnip.extras.filetype_functions')

local f = luasnip.function_node

luasnip.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
    ft_func = filetype_functions.from_pos_or_filetype,
    snip_env = {
        snippet = luasnip.snippet,
        parse = luasnip.parser.parse_snippet,
        fmt = require('luasnip.extras.fmt').fmt,
        c = luasnip.choice_node,
        d = luasnip.dynamic_node,
        f = luasnip.function_node,
        i = luasnip.insert_node,
        s = luasnip.snippet_node,
        t = luasnip.text_node,
        r = function(index) 
            return f(function(arg) return arg[1] end, {index})
        end,
        conds = require("luasnip.extras.conditions"),
        conds_expand = require("luasnip.extras.conditions.expand"),
    }
})

local opts = {noremap = true, silent = true}

vim.keymap.set({"i", "s"}, "<C-j>", 
function() 
    if luasnip.expand_or_jumpable() then 
        luasnip.expand_or_jump() 
    end 
end, opts)


vim.keymap.set({"i", "s"}, "<C-k>", 
function() if luasnip.jumpable(-1) then luasnip.jump(-1) end end, opts)


vim.keymap.set({"i", "s"}, "<C-z>", 
function() 
    if luasnip.choice_active() then 
        luasnip.change_choice(1) 
    end 
end, opts)

local rt_path = string.sub(vim.inspect(vim.api.nvim_list_runtime_paths()[1]), 2, -2)

require("luasnip.loaders.from_lua").load({paths = rt_path .. "/lua/snippets"})

require("luasnip.loaders.from_snipmate").lazy_load()
