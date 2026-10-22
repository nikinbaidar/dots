#!/usr/bin/env lua

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    snippets = {
        preset = 'luasnip'
    },
    keymap = {
        preset = 'super-tab',
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})
