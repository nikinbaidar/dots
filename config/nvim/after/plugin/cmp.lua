local cmp = require'cmp'
local luasnip = require("luasnip")
local background = "#03051E"

vim.api.nvim_set_hl(0, "MyCmpCompletion", {bg = background })
vim.api.nvim_set_hl(0, "MyCmpDocumentation", {bg = background, })
vim.api.nvim_set_hl(0, "MyCmpBorder", {bg = background, fg="#393E46"})

cmp.setup({
    event = { "InsertEnter", "CmdlineEnter" },
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = "Normal:MyCmpCompletion,FloatBorder:MyCmpBorder",
            scrollbar = false
        }),
        documentation = cmp.config.window.bordered({
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = "Normal:MyCmpCompletion,FloatBorder:MyCmpBorder",
            max_width = math.floor(vim.o.columns * 0.9),
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        {name = "luasnip", priority= 1000},
        {name = "nvim_lsp", priority= 100},
        {name = "buffer", priority = 500},
        {name = "path", priority = 400},
    })
})

