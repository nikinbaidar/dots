local item = "\\item "

local function mklabel(args) 
    local x = string.lower(args[1][1])
    x = string.gsub(x, "%s+", "-")
    return x
end

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
    -- This behaves slightly different than `make_jumpable_cols`.
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
    parse({trig="latex", snippetType="autosnippet", desc="LaTeX"}, "\\LaTeX{}"),

    s({trig="title", desc="Make Title"}, {
        t("\\title{"), i(1), t({"}", ""}),
        t("\\author{"), i(2), t({"}", ""}),
        t("\\date{"), i(2), t({"}", ""}),
    }),

    s({trig="dcl", snippetType="autosnippet", desc="Set document class"}, {
        t("\\documentclass[a4 paper,"), i(2), t("]{"), i(1, "article"), t({"}", "", ""}), i(3),
    }),

    ms({ "use", "up", "pac" }, {
        t("\\usepackage"), i(2), t("{"), i(1), t({"}", ""}),
        i(3),
    }),

    s({trig="$$", snippetType="autosnippet", desc="Inline math"}, {
        t"$", i(1), t"$", i(2),
    }),

    s({trig="beg", desc="Begin an environment"}, {
        t"\\begin{", i(1), t"}", i(2), t{"", ""},
        m(1, "document", "\n", ""), m(1, "document", "", "\t"),
        i(3),
        m(1, "document", "\n", ""),
        t{"", "\\end{"}, rep(1), t({"}", "", ""}),
        i(4),
    }),

    s({trig = "cha", desc="Chapter Heading", docTrig="cha"}, {
        t("\\chapter{"), i(1), t("}"),
        t({"", "\\label{cha:"}), 
        f(mklabel, 1),
        t({"}", "", ""}),
    }),

    s({trig = "sec", desc="Section Heading"}, {
        t("\\section{"), i(1), t("}"),
        t({"", "\\label{sec:"}),
        f(mklabel, 1),
        t({"}", "", ""}),
    }),

    s({trig = "sub", desc="Sub Section Heading"}, {
        t("\\subsection{"), i(1), t("}"),
        t({"", "\\label{sub:"}),
        f(mklabel, 1),
        t({"}", "", ""}),
    }),

    s({trig = "ssub", desc="Sub x2 section heading"}, {
        t("\\subsubsection{"), i(1), t("}"),
        t({"", "\\label{ssub:"}),
        f(mklabel, 1),
        t({"}", "", ""}),
    }),

    s({trig="ref", desc="Cross reference"}, {
        m(1, "cha*", "section~", ""),
        m(1, "sec*", "section~", ""),
        m(1, "sub*", "section~", ""),
        m(1, "ssub*", "section~", ""),
        m(1, "fig*", "Figure~", ""),
        m(1, "tab*", "Table~", ""),
        m(1, "eq*", "Equation~", ""),
        t("\\ref{"), i(1), t("}")
    }),

    s({trig="pref", desc="Cross reference"}, {
        t(" on page~\\pageref{"), i(1), t("}")
    }),

    ms({
        {trig="im", desc="Recursive \\item" },
        {trig="\\it", snippetType="autosnippet"},
    }, {
        t(item), i(1), t({"", ""}), d(2, recursive_item, {}),
    }),




    s({trig = "fig", desc="Figure environment" }, {
        t({"\\begin{figure}[h]", "\\centering", ""}),
        t("\\includegraphics[scale="), i(3, "0.50"), t("]{./"), i(1), t({"}", ""}),
        i(2), t("\\caption{}"),
        t({"", "\\label{fig:"}),
        rep(1), t("}"),
        t({"", "\\end{figure}", ""}),
    }),

    s({trig="tab", desc="Snip Test 2"}, {
        t({"\\begin{table}", ""}),
        t({"\t\\begin{tabular}{"}), i(1), t({"}", ""}),
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

}
