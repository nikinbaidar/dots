vim.cmd.colorscheme("ayu-dark")

vim.cmd("hi! SpellCap gui=None") 
vim.api.nvim_set_hl(0, "IncSearch", { reverse=true, fg="#ffa700" })
vim.api.nvim_set_hl(0, "LineNr", { fg="gray", bg="none" })
vim.api.nvim_set_hl(0, "Visual", { bg="#23344b" })
vim.api.nvim_set_hl(0, "@markup.link.label", { fg="#44A1A4" })
vim.api.nvim_set_hl(0, "@markup.link.url", { fg="#b489fa" })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { fg="#FFC349", underline=false })
