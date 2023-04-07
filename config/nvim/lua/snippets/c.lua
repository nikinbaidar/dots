
return {

    snippet({
        trig = "io",
        snippetType = "autosnippet"
    }, {
        t ("#include <stdio.h>")
    }, {
        condition = conds_expand.line_begin 
    }),

    snippet({ trig = "inc", snippetType = "autosnippet"}, {
        c(1, { 
            s(1, {
                t ("#include <"), i(1), t({".h>", ""})
            }),
            s(2, {
                t ("#include \""), i(1), t({"\"", ""})
            }),
        }) 
    }, {
        condition = conds_expand.line_begin 
    }),

    snippet({ trig = "pf", snippetType = "autosnippet"}, fmt("printf(\"{}\"{});",
    {
        i(1), i(2)
    }), {
        condition = conds_expand.line_begin 
    }),

    snippet({
        trig = "fn",
        snippetType = "autosnippet"
    }, {
		i(1),
		m(1, "[v]", "oid "),
		m(1, "[i]", "nt "),
		m(1, "[f]", "loat "),
		m(1, "[d]", "ouble "),
		m(1, "[l]", "ong int "),
        i(2, "main()"),
        t(" "),
        t({"{", "\t"}),
        i(3),
        t({"", "}"}),
	}, {
        condition = conds_expand.line_begin 
    }),


}
