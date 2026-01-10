local ls = require("luasnip")
local extras = require("luasnip.extras")
local filetype_functions = require('luasnip.extras.filetype_functions')
local f = ls.function_node

ls.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    ft_func = filetype_functions.from_pos_or_filetype,
    snip_env = {
        snippet = ls.snippet,
        s = ls.snippet,
        sn = ls.snippet_node,
        t = ls.text_node,
        i = ls.insert_node,
        f = ls.function_node,
        c = ls.choice_node,
        d = ls.dynamic_node,
        r = ls.restore_node,
        l = require("luasnip.extras").lambda,
        rep = require("luasnip.extras").rep,
        p = require("luasnip.extras").partial,
        m = require("luasnip.extras").match,
        n = require("luasnip.extras").nonempty,
        dl = require("luasnip.extras").dynamic_lambda,
        fmt = require("luasnip.extras.fmt").fmt,
        fmta = require("luasnip.extras.fmt").fmta,
        types = require("luasnip.util.types"),
        conds = require("luasnip.extras.conditions"),
        conds_expand = require("luasnip.extras.conditions.expand"),
        prase = ls.parser.parse_snippet,
        trigger = function() return f(function(_, snip) return snip.trigger end, {}) end,
        T = function() return f(function(_, snip) return snip.trigger end, {}) end,
        C = function() return f(function(_, snip) return snip.captures[1] end, {}) end,
    },
    enable_autosnippets = true,
})

local extensions = {
    javascript = {"html", "react"},
    html = {"css", "javascript"},
    plaintex = {"tex"},
    makrdown = {"tex", "quarto"}
}

for ft, ext in pairs(extensions) do 
    ls.filetype_extend(ft, ext)
end

require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })

local expand_or_jump = function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

local jump_previous = function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

local change_choice = function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end
--
vim.keymap.set({ "i", "s" }, "<C-j>", expand_or_jump, { noremap = true, silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", jump_previous, { noremap = true, silent = true })
vim.keymap.set({ "i", "s" }, "<C-l>", change_choice, { noremap = true, silent = true })
