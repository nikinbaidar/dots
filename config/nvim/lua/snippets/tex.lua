local rec_item

rec_item = function()
    return s(nil,
    c(1, {
        t({""}),
        s(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_item, {}) })
    })
    )
end


return {

    
    parse({
        trig = "bls",
        snippetType = "autosnippet"
    }, [[\enlargethispage{\baselineskip}]]),

    snippet("w", fmt("{} & {} & {} \\\\", {
        i(1, "ROOT"),
        i(2, "MEANING"),
        i(3)
    })), 

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
    snippet("li", fmt([[
    \begin{{{}}}
        \item {}{}
    \end{{{}}}
    ]], { 
        c(1, { t "itemize", t "enumerate" }),
        i(2),
        d(3, rec_item, {}),
        r(1) 
    })),

}
