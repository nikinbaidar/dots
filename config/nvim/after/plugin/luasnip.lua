--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░

local luasnip = require("luasnip")

luasnip.setup({
    ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
})

local extras = require('luasnip.extras')
local fmt = require('luasnip.extras.fmt').fmt

local rep = extras.rep

local snippet = luasnip.snippet
local s = luasnip.snippet_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local p = luasnip.parser.parse_snippet
local f = luasnip.function_node
local i = luasnip.insert_node
local t = luasnip.text_node

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

local lorem = [[

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

]]

local date = function() 
    return {os.date('%Y-%m-%d')} 
end

luasnip.add_snippets(nil, {


    all = {
        
        p("lorem", lorem),

        snippet("date", {
            f(date, {})
        }),

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
                i(2),
                t "all",
                t "top-bottom right-left",
                t "top left bottom right",
                t "top right-left bottom",
            })
        })), 

        snippet("b", fmt("{} : {} {} #{};",  {
            c(1, { 
                t "border", 
                t "border-top",
                t "border-left",
                t "border-right",
                t "border-bottom",
            }),
            i(2, "1px"), 
            i(3, "solid"), 
            i(4, "000")
        })), 

    },


    javascript = {

        p("#!", "#!/usr/bin/env node"),

    },


    lua = { 

        p("#!", "#!/usr/bin/env lua"),

        snippet("req", fmt("local {} = require('{}')", {
            i(1), i(2) 
        })),

    },


    markdown = { 

        snippet("sec", fmt("## {}",  {
            i(1, "Section") 
        })),

        snippet("sub", fmt("### {}", {
            i(1, "Sub Section") 
        })),

        snippet("link", fmt("[{}]({})", {
            i(1, "Anchor"), i(2, "URL")
        })),

    },


    python = {

        p("#!", "#!/usr/bin/env python"),

    },


    tex = { 

        snippet ("beg", { 
            t("\\begin{"), i(1), t("}"), i(0), t("\\end{"), i(1), t("}") 
        })

    }, 

})
