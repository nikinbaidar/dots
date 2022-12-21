--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░

local luasnip = require("luasnip")
--
-- Global short hands.
snippet = luasnip.snippet
fn_node = luasnip.function_node
tx_node = luasnip.text_node
in_node = luasnip.insert_node

vim.keymap.set({"i", "s"}, "<Tab>",
function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    end
end,  
{silent = true})

vim.keymap.set({"i", "s"}, "<S-Tab>",
function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end,  
{silent = true})
                
--

require("luasnip.loaders.from_snipmate").lazy_load()

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local lorem = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.]]

local date = function() 
    return {os.date('%Y-%m-%d')} 
end


-- ╔═╗┌┐┌┬┌─┐┌─┐┌─┐┌┬┐  ╔╦╗┌─┐┌┐ ┬  ┌─┐
-- ╚═╗││││├─┘├─┘├┤  │    ║ ├─┤├┴┐│  ├┤ 
-- ╚═╝┘└┘┴┴  ┴  └─┘ ┴    ╩ ┴ ┴└─┘┴─┘└─┘

luasnip.add_snippets(nil, {

    all = {
        
        luasnip.parser.parse_snippet("lorem", lorem),

        snippet("date", { 
            fn_node(date, {}), 
        }),
    },


    lua = { 

        snippet("req", fmt("local {} = require('{}')", {
            in_node(1, "deafult"),
            in_node(2, "default") 
        })),

    },


    markdown = { 

        snippet("sec", fmt( "# {}", {
            in_node(1, "Section")
        })),

    },

































































})

