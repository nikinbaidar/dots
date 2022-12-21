--
-- ░█░░░█░█░█▀█░█▀▀░█▀█░▀█▀░█▀█
-- ░█░░░█░█░█▀█░▀▀█░█░█░░█░░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░░

local luasnip = require("luasnip")
--
-- Global short hands.
luasnippets = luasnip.add_snippets
snippet = luasnip.snippet
fn_node = luasnip.function_node
tx_node = luasnip.text_node
in_node = luasnip.insert_node

local parameters = { noremap = ture, silent = true}

vim.keymap.set({"i", "s"}, "<Tab>",
function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end,
parameters)

vim.keymap.set({"i", "s"}, "<S-Tab>",
function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end,  
parameters)

require("luasnip.loaders.from_snipmate").lazy_load()


-- ╔╦╗┬ ┬  ╔═╗┌┐┌┬┌─┐┌─┐┌─┐┌┬┐┌─┐
-- ║║║└┬┘  ╚═╗││││├─┘├─┘├┤  │ └─┐
-- ╩ ╩ ┴   ╚═╝┘└┘┴┴  ┴  └─┘ ┴ └─┘

local date = function() return {os.date('%Y-%m-%d')} end

local lorem_ipsum = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ]]

luasnip.add_snippets(nil, {
    all = {
        snippet({ trig = "date" }, {
            fn_node(date, {}),
        }),

        snippet({ trig = "lorem" }, {
            tx_node(lorem_ipsum, {})
        }),
    }
})
