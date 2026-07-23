#!/usr/bin/env lua

local function run_c()
    vim.cmd("update")
    vim.cmd('! gcc -o /tmp/a.out -lm % && /tmp/a.out ')
end

vim.keymap.set("n", "<leader>r", run_c, {desc="Compile and run C with gcc", buffer=true})
