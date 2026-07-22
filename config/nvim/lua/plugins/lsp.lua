-- See `:help vim.lsp.config`.

vim.lsp.config['pyright'] = {
    cmd = { 'pyright-langserver', '--stdio'},
    filetypes = { 'python' },
    root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
}

vim.lsp.enable({"pyright"})
