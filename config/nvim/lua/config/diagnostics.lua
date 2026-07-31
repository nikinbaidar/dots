local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "", }

vim.diagnostic.config({
    float = { border = "single", },
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
