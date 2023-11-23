--
-- ░▀█▀░█▀█░▀█▀░▀█▀░░░░█░░░█░█░█▀█
-- ░░█░░█░█░░█░░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀░▀░▀


require("core.plugins")
require("core.options")
require("core.keymaps")
require("core.augroup")

vim.cmd("colorscheme habamax")

vim.cmd[[
hi link TelescopeSelection CursorLine
]]
