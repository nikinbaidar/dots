--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█░░░░█░░░█░█░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

local luasnip
local filetype_functions
local opts = { noremap = true, silent = true }
local f

luasnip = require("luasnip")
luasnip_extras = require("luasnip.extras")
filetype_functions = require('luasnip.extras.filetype_functions')
f = luasnip.function_node
opts = { noremap = true, silent = true }

luasnip.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    ft_func = filetype_functions.from_pos_or_filetype,
    load_ft_func = filetype_functions.extend_load_ft({
        html = { "javascript", "css" }
    }),
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
        m = luasnip_extras.match,
        p = luasnip_extras.partial,
        r = function(index)
            return f(function(arg) return arg[1] end, { index })
        end,
        getTrig = function()
            return f(function(_, snip) return snip.trigger end, {})
        end,
        getTrigNum = function()
            return f(function(_, snip)
                -- print(type(snip.trigger))
                local numericPart = string.match(snip.trigger, "%d+")
                return numericPart
            end, {})
        end,
        conds = require("luasnip.extras.conditions"),
        conds_expand = require("luasnip.extras.conditions.expand"),
    },
    enable_autosnippets = true,
})

luasnip.filetype_extend("javascript", { "html", "react" })
luasnip.filetype_extend("latex", { "tex" })
luasnip.filetype_extend("markdown", { "quarto" })

getChoice = function(arg) return arg[1][1] end


-- -- KEYMAPS
--
local expand_or_jump
local jump_previous
local change_choice

expand_or_jump = function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end

jump_previous = function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end

change_choice = function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end

vim.keymap.set({ "i", "s" }, "<C-j>", expand_or_jump, opts)
vim.keymap.set({ "i", "s" }, "<C-k>", jump_previous, opts)
vim.keymap.set({ "i", "s" }, "<C-l>", change_choice, opts)

require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
--
require("luasnip.loaders.from_snipmate").lazy_load()
