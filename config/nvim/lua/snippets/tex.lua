local rec_item 

rec_item = function()
    return s(
    nil,
    c(1, {
        t({""}),
        s(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_item, {}), }),
    })
    )

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

    snippet("w", fmt("{} & {} & {} \\\\", {
        i(1, "ROOT/AFFIX"),
        i(2, "MEANING"),
        i(3)
    })), 

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

    snippet("di", fmt([[
    \item [{}.] {}
    ]], { i(1), i(2) })),

}

