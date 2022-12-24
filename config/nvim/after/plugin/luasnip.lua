--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░

local luasnip = require("luasnip")
local filetype_functions = require('luasnip.extras.filetype_functions')
local extras = require('luasnip.extras')
local fmt = require('luasnip.extras.fmt').fmt
local snippet = luasnip.snippet
local parse_snippet = luasnip.parser.parse_snippet
local s = luasnip.snippet_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local f = luasnip.function_node
local i = luasnip.insert_node
local t = luasnip.text_node
-- Custom repeat node
local r = function(index) 
    return f(function(arg) 
        return arg[1]
    end, { index })
end

luasnip.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    -- Context specific snippets
    ft_func = filetype_functions.from_pos_or_filetype,
})

vim.keymap.set({"i", "s"}, "<Tab>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
        "<Tab>", true, false, true), "n", false)
    end
end, {noremap = true, silent = true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, {noremap = true, silent = true})

vim.keymap.set({"i", "s"}, "<C-l>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, {noremap = true, silent = true})


-- ╔═╗┌┐┌┬┌─┐┌─┐┌─┐┌┬┐  ╔╦╗┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐
-- ╚═╗││││├─┘├─┘├┤  │    ║║├┤ ├┤ │││││ │ ││ ││││└─┐
-- ╚═╝┘└┘┴┴  ┴  └─┘ ┴   ═╩╝└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘

--[[ 
luasnip.filetype_extend("javascript", {
    "html",
}) ]]

require("luasnip.loaders.from_snipmate").lazy_load()

local bang = "#!/usr/bin/env "
local lorem = [[

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

]]


-- Functions for f nodes.

local date = function() 
    return {os.date('%Y-%m-%d')} 
end

local luaimport = function(import_name)
    local parts = vim.split(import_name[1][1], ".", true)
    return parts[#parts] or ""
end

-- Snippet Table:

luasnip.add_snippets(nil, {
    all = {
        
        parse_snippet("lorem", lorem),

        snippet("date", {
            f(date, {})
        }),

        snippet("same", fmt([[example: {}, reproducedhere: {}]], { i(1), r(1)})),

    },


    css = {

        snippet("m", fmt("{} : {};",  {
            c(1, { 
                t "margin", 
                t "margin-top",
                t "margin-left",
                t "margin-right",
                t "margin-bottom",
            }),
            c(2, {
                i(2, "all"),
                i(2, "top-bottom right-left"),
                i(2, "top left bottom right"),
                i(2, "top right-left bottom"),
            })
        })), 

        snippet("p", fmt("{} : {};",  {
            c(1, { 
                t "padding", 
                t "padding-top",
                t "padding-left",
                t "padding-right",
                t "padding-bottom",
            }),
            c(2, {
                i(2, "all"),
                i(2, "top-bottom right-left"),
                i(2, "top left bottom right"),
                i(2, "top right-left bottom"),
            })
        })), 

        snippet("b", fmt("{} : {} {} {};", {
            c(1, { 
                t "border", 
                t "border-top",
                t "border-left",
                t "border-right",
                t "border-bottom",
            }),
            i(2, "1px"), 
            i(3, "solid"), 
            i(4, "#000")
        })), 

    },


    javascript = {

        parse_snippet("#!", bang .. "node"),

    },


    lua = { 

        parse_snippet("#!", "#!/usr/bin/env lua"),

        snippet("req", fmt([[local {} = require('{}')]], {
            f(luaimport, {1}),
            i(1)
        }))
    },


    markdown = { 

        snippet("sec", fmt("## {}",  {
            i(1, "Section") 
        })),

        snippet("sub", fmt("### {}", {
            i(1, "Sub Section") 
        })),

        snippet("link", fmt("[{}]({})", {
            i(1, "Anchor"),
            i(2, "URL")
        })),

    },


    python = {

        parse_snippet("#!", "#!/usr/bin/env python"),

    },


    tex = { 

        snippet ("beg", { 
            t("\\begin{"), i(1), t("}"), i(0), t("\\end{"), i(1), t("}") 
        })

    }, 

})
