#!/usr/bin/env lua

vim.bo.shiftwidth  = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

local function run_js()
    vim.cmd("update")
    vim.cmd('! node %')
end

vim.keymap.set("n", "<leader>r", run_js, {desc="Run javascript with node", buffer=true})
