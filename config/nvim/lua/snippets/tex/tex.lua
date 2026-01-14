local item = "\\item "

local function recursive_item()
    return sn(nil, c(1, {
        t("% Press <C-l> to add item"),
        sn(nil, {
            t(item),
            i(1),
            t({"", ""}),
            d(2, recursive_item, {}),
        }),
    }))
end


local function make_jumpable_cols(index, n)
    -- NOTE: THIS FUCNTION ACHIEVES
    -- [this](https://github.com/L3MON4D3/LuaSnip/issues/1422#issue-3809595769).
    local nodes = {}
    if index then
        table.insert(nodes, t(" & "))
    end
    for col = 1, n-1 do
        table.insert(nodes, i(col))
        table.insert(nodes, t(" & "))
    end
    table.insert(nodes, i(n))
    table.insert(nodes, t(" " .. "\\\\"))
    return sn(index, nodes)
end


local function make_cols(_, snip)
    -- WARN: DO NOT CHANGE OR DELETE THIS FUNCTION
    -- This behaves slightly different than the `make_jumpable_cols` above.
    -- Nonetheless, columns created with `make_cols` are jumpable too; they are
    -- just triggered differetly and it is only necessary to trigger this once
    -- in a table. `make_jumpable_rows` handles the remaining rows.
    local n = tonumber(snip.captures[1])
    return make_jumpable_cols(nil, n)
end


local function repeat_jumpable_rows(args)
    local _, n = string.gsub(args[1][1], "&", "")
    return sn(nil, c(1, {
        t("% Press <C-l> to add row"),
        sn(nil, {
            i(1),
            make_jumpable_cols(2, n),
            t({"", "\t\t"}),
            d(3, repeat_jumpable_rows, 2, {}),
        }),
    }))
end


local function repeat_rows(args)
    return sn(nil, c(1, {
        t("% Press <C-l> to add row"),
        sn(nil, { i(1), sn(2, t({args[1][1], "\t\t"})),  d(3, repeat_rows, 2, {}) }),
    }))
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
        m(1, "document", string.rep("\n", 2), ""),
        m(1, "document", "", "\t"),
        m(1, "itemize", item),
        i(3),
        m(1, "document", string.rep("\n", 2), ""),
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

    s({trig="im", snippetType="autosnippet", desc="Repeat \\item-s"}, {
        t(item),
        i(1),
        t({"", ""}),
        d(2, recursive_item, {}),
        t({"", ""}),
        i(3)
    }),


    s({trig = "fig", desc="Figure environment" }, {
        t({"\\begin{figure}[h]", "\\centering", ""}),
        t("\\includegraphics[scale="), i(3, "0.50"), t("]{./"), i(1), t({"}", ""}),
        i(2), t("\\caption{}"),
        t({"", "\\label{fig:"}),
        rep(1), t("}"),
        t({"", "\\end{figure}", ""}),
    }),

    s({trig="tab", desc="Snip Test", docTrig="tab1"}, {
        t({"\\begin{table}", ""}),
        t({"\t\\begin{tabular}"}), i(1), t({"", ""}),
        t({"\t\t\\hline"}), t({"", "\t\t"}),
        i(2),t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t\t"}),
        d(3, repeat_rows, 2, {}),
        t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t"}),
        t({"\\end{tabular}"}), t({"", ""}),
        t({"\\end{table}"}),
    }),


    s({trig="tab2", desc="Snip Test 2"}, {
        t({"\\begin{table}", ""}),
        t({"\t\\begin{tabular}"}), i(1), t({"", ""}),
        t({"\t\t\\hline"}), t({"", "\t\t"}),
        i(2),t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t\t"}),
        d(3, repeat_jumpable_rows, 2, {}),
        t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t"}),
        t({"\\end{tabular}"}), t({"", ""}),
        t({"\\end{table}"}),
    }),

    s({trig = "col(%d)", regTrig = true, docTrig = "col1"}, {
        d(1, make_cols , {}),
    }),

    s("extras2", {
        i(1, "INPUT"), t { "", "" }, m(1, l._1:match(l._1:reverse()), "PALINDROME")
    }),

    s("isn", {
        isn(1, {
            t({"This is indented as deep as the trigger",
            "and this is at the beginning of the next line"})
        }, "")
    }),

    s("trig", {
        i(1, "change to update"),
        d(2, count, {1})
    }),

}
