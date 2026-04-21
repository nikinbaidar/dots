require('vim._core.ui2').enable()
vim.cmd("packadd nvim.tohtml")

require("options")
require("keymaps")
require("augroup")
require("plugins")
require("colors")
