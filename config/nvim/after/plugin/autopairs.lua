local npairs = require "nvim-autopairs"
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

npairs.setup {
    check_ts = true,
    ts_config = {
        lua = {'string'}
    },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}

-- If you want insert `(` after select function or method item
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
