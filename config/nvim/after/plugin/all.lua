require("ibl").setup {
    scope = { enabled = false },
}

-- FIX: hint
-- sjflksdjlfksjd

require("todo-comments").setup({
    signs = false, 
    keywords = {
        FIX =  { color = "error", alt= {"FAILS"} },
        TODO = { color = "info", alt = {} },
        WARN = { color = "warning", alt = { "HACK"} },
        PERF = { color = "#8B5DFF", alt = { "INFO", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { color = "hint", alt = { "IDEA", } },
    },
    highlight = {
        multiline = true,
        before = "",
        keyword = "wide",
        after = "fg",
    },
})
