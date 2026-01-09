local cmp = require'cmp'
local background = "#03051E"

vim.api.nvim_set_hl(0, "CmpCompletion", {bg = background })
vim.api.nvim_set_hl(0, "CmpDocumentation", {bg = background, })
vim.api.nvim_set_hl(0, "CmpCompletionBorder", {bg = background, fg="#393E46"})

cmp.setup({
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
            winhighlight = "Normal:CmpCompletion,FloatBorder:CmpCompletionBorder",
            scrollbar = false
        }),
        documentation = cmp.config.window.bordered({
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpCompletionBorder",
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        {name = "luasnip", priority= 1000},
        {name = "buffer", priority = 500},
        {name = "path", priority = 250}
    })
})



