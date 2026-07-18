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

-- vim.api.nvim_create_user_command(
--     "ShowDiagnostics",
--     function() vim.diagnostic.open_float() end,
--     {desc = "Display LSP diagnostics"}
-- )
