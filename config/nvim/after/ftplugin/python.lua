#!/usr/bin/env lua

local function run_py()
    vim.cmd("update")
    vim.cmd('! python %')
end

vim.keymap.set("n", "<leader>r", run_py, {desc="Run py", buffer=true})
