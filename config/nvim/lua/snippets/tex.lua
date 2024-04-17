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
        trig = "ohm", 
    }, "$\\Omega$"),

    parse({
        trig = "jw", 
    }, "$j\\omega$"),




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

    snippet("slide", fmt([[
    \begin{{frame}}
        \frametitle{{{}}}
        \subsection{{{}}}
        {}
        \vfill
    \end{{frame}}
    ]], { i(1), r(1), i(2)})),

    snippet("tc", fmt([[
    \textcolor{{magenta}}{{{}}}
    ]], {i(1)})),

    parse({
        trig = "baselineskip",
        snippetType = "autosnippet",
    }, [[\enlargethispage{\baselineskip}]]
    ),

   snippet({
       trig = "use"
   }, {
        t("\\usepackage{"), i(1), t("}"),
    }),

   snippet({
       trig = "\\q"
   }, {
        t({"\\question", ""}),
        i(1),
        t({"", "\\begin{choices}"}),
        t({"", "    \\choice "}), i(2),
        t({"", "    \\choice "}), i(3),
        t({"", "    \\choice "}), i(4),
        t({"", "    \\choice "}), i(5),
        t({"", "\\end{choices}", ""}),
    }),

   snippet({
       trig = "\\m"
   }, {
        t("\\["), i(1), t("\\]")
   }),

   snippet({
       trig = "fig" }, {
        t({"\\begin{figure}[h]", "\\centering", ""}),
        t("\\includegraphics[scale="), i(3, "0.50"), t("]{./"),
        i(1), t({"}", ""}),
        i(2), t("\\caption{}"), 
        t({"", "\\label{fig:"}), 
        r(1), t("}"),
        t({"", "\\end{figure}", ""}),
    }),

    -- snippet({ trig = "(%a+)", regTrig=true}, {
    --     t"\\", getTrig()
    -- }),

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

    snippet({trig = "vs(%d+)", regTrig = true}, fmt("\\vspace{{{}pt}}", {
        getTrigNum()
    })),


    snippet( {trig = "(.*)fn", regTrig = true},
    fmt("{}\\footnote{{{}}}", {
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        i(1),
    })),

    snippet( {trig = "frac"},
    fmt("\\displaystyle\\frac{{{}}}{{{}}}", {
        i(1), i(2)
    })),

    snippet("ls", {
        t("\\begin"),
        c(1, { t("{itemize}"), t("{enumerate}"), }),
        t({ "", "\t\\item " }), i(2), d(3, rec_item, {}),
        t({ "", "\\end" }), r(1)
    }),

    snippet("doc", fmt([[
    \documentclass{{{}}}
    
    \begin{{document}}

    {}

    \end{{document}}
    ]], { i(1), i(2) })),

    snippet("beg", fmt([[
    \begin{{{}}}
    {}
    \end{{{}}}
    ]], { i(1), i(2), r(1) })),



}

