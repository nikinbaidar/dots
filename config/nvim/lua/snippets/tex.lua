local rec_item 
local rec_etymology

rec_item = function()
    return s(
    nil,
    c(1, {
        t({""}),
        s(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_item, {}), }),
    }))
end

rec_etymology = function()
    return s(
    nil,
    c(1, {
        t({""}),
        s(nil, {
            t({"", ""}),
            i(1, "ROOT/AFFIX"), t(" & "),
            i(2, "MEANING"),t (" & "),
            i(3), t({" \\\\"}),
            d(4, rec_etymology, {}),
        }),
    }))
end

return {

    parse({
        trig = "hypersetup",
        snippetType = "autosnippet",
    }, [[
    \usepackage{hyperref}

    \hypersetup{
        colorlinks=true,
        linkcolor=black,
        filecolor=magenta,      
        urlcolor=blue,
    }

    \newcommand{\hrefund}[2]{\href{#1}{\underline{#2}}}
    ]]),

    parse({
        trig = "baselineskip",
        snippetType = "autosnippet",
    }, [[\enlargethispage{\baselineskip}]]
    ),

    snippet("w", {
        i(1, "ROOT/AFFIX"), t(" & "),
        i(2, "MEANING"),t (" & "),
        i(3), t({" \\\\"}),
        d(4, rec_etymology, {}),
    }),

    snippet({trig = "sec"},
    {
        t("\\section{"), i(1), t("}"),
        t({"", "\\label{sec:"}), r(1), t({"}", "", ""}),
    }),


    snippet( {trig = "(.*)fn", regTrig = true},
    fmt("{}\\footnote{{{}}}", {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        i(1),
    })),



    snippet("ls", {
        t("\\begin"),
        c(1, { t("{itemize}"), t("{enumerate}"), }),
        c(2, { t({"[noitemsep]"}), t({""}), }),
        t({ "", "\t\\item " }), i(3), d(4, rec_item, {}),
        t({ "", "\\end" }), r(1)
    }),


    snippet("doc", fmt([[
    \documentclass[14pt]{{extarticle}}
    \usepackage[margin=1in]{{geometry}}
    \usepackage{{enumitems}}

    \begin{{document}}
    {}
    \end{{document}}
    ]], { i(1) })),

    snippet("beg", fmt([[
    \begin{{{}}}
    {}
    \end{{{}}}
    ]], { i(1), i(2), r(1) })),


}

