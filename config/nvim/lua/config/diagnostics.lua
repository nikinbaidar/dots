#!/usr/bin/env lua

local signs = {
    [vim.diagnostic.severity.ERROR] = "✗",
    [vim.diagnostic.severity.WARN]  = "",
    [vim.diagnostic.severity.INFO]  = "",
    [vim.diagnostic.severity.HINT]  = "󰌵",
}

vim.diagnostic.config({
    float = { border = "single", },
    signs = { text = signs, },
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
        })
    end,
})

vim.opt.updatetime = 250
