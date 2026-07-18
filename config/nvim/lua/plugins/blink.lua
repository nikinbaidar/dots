local cmp = require('blink.cmp')
cmp.build():pwait()

cmp.setup({
    snippets = {
        preset = 'luasnip'
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})
