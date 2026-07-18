-- See `:help vim.lsp.config`.

vim.lsp.config['pyright'] = {
    cmd = { 'pyright-langserver', '--stdio'},
    filetypes = { 'python' },
    root_makrs = {},
}

vim.lsp.enable({"pyright"})
