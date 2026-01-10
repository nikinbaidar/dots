local item = "\\item "
local recursive_item

recursive_item = function()
    return sn( nil, c(1, {
            t(""),
            sn(nil, { t({ "", item}), i(1), d(2, recursive_item, {}) }),
        })
    )
end

return {
    parse({trig="latex", desc="LaTeX"}, "\\LaTeX{}"),

    s({trig="dcl", snippetType="autosnippet", desc="document class"}, {
        t("\\documentclass[a4 paper,"), i(2), t("]{"), i(1), t("}"),
    }),

    s({trig="up", desc=""}, {
        t("\\usepackage"),
        c(1, {
            sn(nil, {t("{"), i(1), t("}")}),
            sn(nil, {t("["), i(1), t("]"), t("{"), i(2), t("}")}),
        }), }
    ),

    s({trig="$$", snippetType="autosnippet", desc="Inline math"}, {
        t"$", i(1), t"$", i(2),
    }),

    s({trig="beg", desc="Begin an environment"}, {
        t"\\begin{", i(1), t{"}", ""},
        m(1, "document", "", "\t"),
        i(2),
        t{"", "\\end{"}, rep(1), t"}",
    }),

    s({trig = "cha", desc="Chapter Heading"}, {
        t("\\chapter{"), i(1), t("}"),
        t({"", "\\label{cha:"}), rep(1), t({"}", "", ""}),
    }),

    s({trig = "sec", desc="Section Heading"}, {
        t("\\section{"), i(1), t("}"),
        t({"", "\\label{sec:"}), rep(1), t({"}", "", ""}),
    }),

    s({trig = "sub", desc="Sub Section Heading"}, {
        t("\\subsection{"), i(1), t("}"),
        t({"", "\\label{sub:"}), rep(1), t({"}", "", ""}),
    }),

    s({trig = "ssub", desc="Sub x2 section heading"}, {
        t("\\subsubsection{"), i(1), t("}"),
        t({"", "\\label{ssub:"}), rep(1), t({"}", "", ""}),
    }),

    s({trig="it", desc="Recursively expands an item list with nested insertion nodes."}, {
        t(item), i(1), d(2, recursive_item, {}),
    }),

    s({trig = "fig", desc="Figure environment" }, {
        t({"\\begin{figure}[h]", "\\centering", ""}),
        t("\\includegraphics[scale="), i(3, "0.50"), t("]{./"),
        i(1), t({"}", ""}),
        i(2), t("\\caption{}"),
        t({"", "\\label{fig:"}),
        rep(1), t("}"),
        t({"", "\\end{figure}", ""}),
    }),

}
