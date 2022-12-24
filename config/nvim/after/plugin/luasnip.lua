--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░

local luasnip = require("luasnip")
local filetype_functions = require('luasnip.extras.filetype_functions')
local fmt = require('luasnip.extras.fmt').fmt
local snippet = luasnip.snippet
local parse = luasnip.parser.parse_snippet
local s = luasnip.snippet_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local f = luasnip.function_node
local i = luasnip.insert_node
local t = luasnip.text_node

luasnip.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    -- Context specific snippets
    ft_func = filetype_functions.from_pos_or_filetype,
})

--[[ 
luasnip.filetype_extend("javascript", {
    "html",
}) ]]


-- ╦╔═┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐
-- ╠╩╗├┤ └┬┘│││├─┤├─┘└─┐
-- ╩ ╩└─┘ ┴ ┴ ┴┴ ┴┴  └─┘


vim.keymap.set({"i", "s"}, "<Tab>", 
function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
        "<Tab>", true, false, true), "n", false)
    end
end, {noremap = true, silent = true})


vim.keymap.set({"i", "s"}, "<S-Tab>",
function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, {noremap = true, silent = true})


vim.keymap.set({"i", "s"}, "<C-l>",
function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, {noremap = true, silent = true})


-- ╔═╗┌┐┌┬┌─┐┌─┐┌─┐┌┬┐  ╔╦╗┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐
-- ╚═╗││││├─┘├─┘├┤  │    ║║├┤ ├┤ │││││ │ ││ ││││└─┐
-- ╚═╝┘└┘┴┴  ┴  └─┘ ┴   ═╩╝└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘

local lorem
local r -- repeat
local colors
local date
local shebang
local luaimport

require("luasnip.loaders.from_snipmate").lazy_load()

lorem = [[

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

]]

r = function(index) 
    return f(function(arg) return arg[1] end, {index})
end


colors = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t "#", i(1, "000") 
            }),
            s(1, {
                i(1, "black") 
            }),
            s(1, {
                t("rgb("),
                i(1, "0"), t(", "),
                i(2, "0"), t(", "),
                i(3, "0"),
                t(")") ,
            }),
            s(1, {
                t("rgba("),
                i(1, "0"), t(", "),
                i(2, "0"), t(", "),
                i(3, "0"), t(", "),
                i(4, "0"),
                t(")"),
            }),
        })) 
    end, {})
end


date = function() 
    return {os.date('%Y-%m-%d')} 
end


shebang = function() 
    return { "#!/usr/bin/env "  .. vim.bo.filetype }
end


luaimport = function(import_name)
    local parts = vim.split(import_name[1][1], ".", true)
    return parts[#parts] or ""
end


-- Snippet Table

luasnip.add_snippets(nil, {


    all = {

        snippet("#!", {
            f(shebang, {})
        }),
        
        parse("lorem", lorem),

        snippet("date", {
            f(date, {})
        }),

        snippet("same", fmt("example: {}, reproducedhere: {}", {
            i(1),
            r(1)
        })),

    },


    css = {

        snippet("c", fmt("{} : {};", {
            c(1, {
                t "color",
                t "background-color"
            }),
            colors(2),
        })),

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
            colors(4),
        })), 

    },


    javascript = {

        parse("#!", "#!/usr/bin/env node"),

    },


    lua = { 

        snippet("snip", fmt('snippet("{}", fmt("{}", {{\n\t{}\n}})),\n', {
            i(1, "TRIGGER"),
            i(2, "STRING"),
            i(3, "NODES"),
        })), 

        snippet("req", fmt([[local {} = require('{}')]], {
            f(luaimport, {1}),
            i(1)
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
            i(1, "Anchor"),
            i(2, "URL")
        })),

    },


    python = {

    },


    tex = { 

        snippet ("beg", { 
            t("\\begin{"), i(1), t("}"), i(0), t("\\end{"), i(1), t("}") 
        })

    }, 


})
