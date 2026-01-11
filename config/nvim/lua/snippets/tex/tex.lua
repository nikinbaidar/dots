local item = "\\item "
local slash = "\\\\"


local function fn (args, parent, user_args)
    return '[' .. args[1][1] .. user_args .. ']'
end


local function make_cols (_, snip)
    local nodes = {}
    local n = tonumber(snip.captures[1])
    for col = 1, n-1 do
        table.insert(nodes, i(col))
        table.insert(nodes, t(" & "))
    end
    table.insert(nodes, i(n))
    table.insert(nodes, t(" " .. slash))
    return sn(nil, nodes)
end


local function recursive_item ()
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
        t"\\begin{", i(1), t"}", i(2), t{"", ""},
        m(1, "document", "", "\t"),
        i(3),
        m(1, "document", string.rep("\n", 3), ""),
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
        t("\\includegraphics[scale="), i(3, "0.50"), t("]{./"), i(1), t({"}", ""}),
        i(2), t("\\caption{}"),
        t({"", "\\label{fig:"}),
        rep(1), t("}"),
        t({"", "\\end{figure}", ""}),
    }),

    s({trig="tab", desc="Snip Test"}, {
        t({"\\begin{table}", ""}),
        t({"\t\\begin{tabular}"}), i(1), t({"", ""}),
        t({"\t\t\\hline"}), t({"", "\t\t"}),
        i(2),t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t\t"}),
        i(3),
        t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t"}),
        t({"\\end{tabular}"}), t({"", ""}),
        t({"\\end{table}"}),
    }),

    s({trig = "col(%d)", regTrig = true, docTrig = "col1"}, {
        d(1, make_cols , {}),
    }),

    s("extras1", {
        i(1), t { "", "" }, m(1, "^ABC$", "A")
    }),

    s("extras2", {
        i(1, "INPUT"), t { "", "" }, m(1, l._1:match(l._1:reverse()), "PALINDROME")
    }),


    s("trig", {
        i(1), t '<-i(1) ',
        f(fn, {2}, { user_args = { slash }}),
        t ' i(2)->', i(2), t '<-i(2) i(0)->', i(0)
    }),

    s("isn", {
        isn(1, {
            t({"This is indented as deep as the trigger",
            "and this is at the beginning of the next line"})
        }, "")
    })

}
