return {

    s({trig="snip", desc="Simple luasnip snippets for nvim."}, {
        t "s({trig=\"", i(1), t "\", ",
        sn(2, c(1, {
            t "desc=\"",
            t "regTrig=true, desc=\"",
            t "snippetType=\"autosnippet\", desc=\"",
            t "regTrig=true, snippetType=\"autosnippet\", desc=\"",
        })),
        i(3), t {"\"}, {", "\t"}, i(4), t {"", "}),"}
    }),

    s({trig="fmta", desc="fmta style luasnip snippets."}, {
        t "s({trig=\"", i(1), t "\", ",
        sn(2, c(1, {
            t "desc=\"",
            t "regTrig=true, desc=\"",
            t "snippetType=\"autosnippet\", desc=\"",
            t "regTrig=true, snippetType=\"autosnippet\", desc=\"",
        })),
        i(3), t {"\"}, fmta([[", ""}, i(4), t {"", "]], {"},
        t {"", "\t"}, i(5),
        t {"", "})),",}
    }),

}



