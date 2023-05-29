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

    snippet("beg", fmt([[
    \begin{{{}}}
    {}
    \end{{{}}}
    ]], { i(1), i(2), r(1) })),

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
