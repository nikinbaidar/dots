local item = "\\item "

return {
    parse({trig="latex", desc="LaTeX"}, "\\LaTeX"),

    s({trig="dcl", snippetType="autosnippet", desc="document class"}, {
        t("\\documentclass[a4 paper,"), i(2), t("]{"), i(1), t("}"),
    }),

    s({trig="$$", snippetType="autosnippet", desc="Inline math"}, {
        t"$",
        i(1),
        t"$",
        i(2),
    }),

    s({trig="beg", desc="Begin an environment"}, {
        t"\\begin{", i(1), t{"}", "\t"},
        m(1, "itemize", item),
        m(1, "enumerate", item),
        i(2),
        t{"", "\\end{"}, rep(1), t"}",
    }),
}
