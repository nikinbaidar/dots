local item = "\\item "

local function mklabel(args)
    -- NOTE: This takes a args then (a) changes args to lowercase,
    -- (b) keeps only alphnumeric and whitespace characters, and (c) replaces
    -- all whitespaces with a single '-'
    local label = string.lower(args[1][1])
    label = label:gsub("[^%w%s]", "")
    label = label:gsub("%s+", "-")
    return label
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

    s({trig="dcl", snippetType="autosnippet", desc="Set document class"}, {
        t("\\documentclass[a4 paper,"), i(2), t("]{"),
        i(1, "a"),
        m(1, "a", "rticle"),
        m(1, "b", "ook"),
        m(1, "r", "eport"),
        t("}"),
    }),

    ms({ "use", "up", "pac" }, {
        t("\\usepackage"),
        m(1, "geo", "[margin=1in]"),
        i(2),
        t("{"), i(1),
        m(1, "geo", "metry"),
        m(1, "ams", "math"),
        t("}"),
    }),

    s({trig="tit", desc="Make Title"}, {
        t("\\title{"), i(1), t({"}", ""}),
        t("\\author{"), i(2, "Nikin Baidar"), t({"}", ""}),
        t("\\date{"), i(3, "\\today"), t("}"),
    }),

    parse({trig="mktit", snippetType="autosnippet", desc="Maketitle"}, "\\maketitle"),

    s({trig="beg", desc="Begin an environment"}, {
        t"\\begin{", i(1), t"}", i(2), t{"", ""},
        m(1, "document", "\n", ""), m(1, "document", "", "\t"),
        i(3),
        m(1, "document", "\n", ""),
        t{"", "\\end{"}, rep(1), t("}"),
    }),

    s({
        trig = "([pcs][aheus][racbu])", regTrig=true,
        docTrig="sec", 
        desc="Part|Chapter|Section|Subsection|Subsubsection "
    }, {
        t("\\"),
        m(2, "par", "part"),
        m(2, "cha", "chapter"),
        m(2, "sec", "section"),
        m(2, "sub", "subsection"),
        m(2, "ssu", "subsubsection"),
        t("{"), i(1), t("} \\label{"),
        D(2, '1'),
        t(":"),
        f(mklabel, 1),
        t("}"),
    }),

    s({trig="l(%a+)", regTrig=true, desc="Set labels for cross-referencing"}, {
        t("\\label{"), X(1), t(":"), i(1), t("}")
    }),

    s({trig="r(%a+)", regTrig=true, desc="Make cross-reference"}, {
        m(1, "cha", "Chapter"),
        m(1, "[s][eus][cbu]", "Section"),
        m(1, "fig", "Figure"),
        m(1, "tab", "Table"),
        m(1, "eq", "Equation"),
        t("~"),
        t("\\ref{"),
        D(1, '1'),
        t(":"),
        i(2),
        t("}")
    }),

    s({trig="pref", desc="Make cross reference to a page number"}, {
        t("on page~\\pageref{"), i(1), t("}")
    }),

    ms({
        {trig="im", desc="Recursive \\item" },
        {trig="\\it", snippetType="autosnippet"},
    }, {
        t(item), i(1), t({"", ""}), d(2, recursive_item, {}),
    }),

    s({trig = "fig", desc="Figure environment" }, {
        t({"\\begin{figure}[h!]", "\t\\centering", ""}),
        t("\t\\includegraphics[width="), i(2, ""), t("\\textwidth]{./"), i(1), t({"}", ""}),
        t("\t\\caption{"), i(3), t({"}", ""}),
        t("\t\\label{fig:"), f(mklabel, 1, {}), t({"}", ""}),
        t("\\end{figure}"),
    }),

    s({trig="tab", desc="Snip Test 2"}, {
        t({"\\begin{table}", ""}),
        t({"\t\\centering", ""}),
        t({"\t\\begin{tabular}{"}), i(1), t({"}", ""}),
        t({"\t\t\\hline"}), t({"", "\t\t"}),
        i(2),t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t\t"}),
        d(3, repeat_jumpable_rows, 2, {}),
        t({"", "\t\t"}),
        t({"\\hline"}), t({"", "\t"}),
        t({"\\end{tabular}"}), t({"", ""}),
        t("\t\\caption{"), i(4), t({"}", ""}),
        t("\t\\label{tab:"), f(mklabel, 4, {}), t({"}", ""}),
        t({"\\end{table}"}),
    }),

    s({trig = "col(%d)", regTrig = true, docTrig = "col1"}, {
        d(1, make_cols , {}),
    }),


    parse({trig="latex", snippetType="autosnippet", desc="LaTeX"}, "\\LaTeX{}"),
}
