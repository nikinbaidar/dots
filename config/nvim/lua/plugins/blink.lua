local cmp = require('blink.cmp')
cmp.build():pwait()

cmp.setup({
    snippets = {
        preset = 'luasnip'
    },
    keymap = {
        [ '<CR>' ] = { 'select_and_accept', 'fallback' },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})
