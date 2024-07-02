--
-- ░▀█▀░█▀█░▀█▀░▀█▀░░░░█░░░█░█░█▀█
-- ░░█░░█░█░░█░░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀░▀░▀

require("core.plugins")
require("core.options")
require("core.keymaps")
require("core.augroup")

vim.cmd "colorscheme quiet"
vim.cmd "TSContextDisable"

-- vim.cmd [[ hi TreeSitterContext guibg=#135D66 gui=reverse,BOLD ]]
vim.cmd [[ hi StatusLine guibg=NONE ]]
