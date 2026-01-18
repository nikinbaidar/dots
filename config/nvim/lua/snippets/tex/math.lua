local function make_jumpable_matrix_cols(index, n)
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


local function repeat_jumpable_matrix_rows(args)
    local _, n = string.gsub(args[1][1], "&", "")
    return sn(nil, c(1, {
        t("% Press <C-l> to add row"),
        sn(nil, {
            i(1),
            make_jumpable_matrix_cols(2, n),
            t({"", "\t"}),
            d(3, repeat_jumpable_matrix_rows, 2, {}),
        }),
    }))
end


return {
    parse("ity", "\\infty"),

    ms({
        {trig=";;", snippetType="autosnippet", desc="Inline math"},
        "mi",
    }, {
        t"$", i(1, " "), t"$"
    }),

    s({trig=";'", snippetType="autosnippet", desc="Inline math with single quotes"}, {
        t"'$", i(1, " "), t"$'"
    }),

    ms({
        {trig=";:", snippetType="autosnippet", desc="Inline math"},
        "mi",
    }, {
        t({"$$", ""}),
        i(1),
        t({"", "$$"}),
    }),

    s({trig="([td]?)fr", regTrig=true, desc="Fraction"}, {
        t("\\"),
        X(1),
        t("frac{"),
        i(1),
        t("}{"),
        i(2),
        t("}"),
    }),

    s({trig="int"}, {
        t("\\int \\; "), i(1, "fn(x)"), t(" \\; d"), i(2, "x")
    }),

    s({trig="oint"}, {
        t("\\int \\; "), i(1, "fn(x)"), t(" \\; d"), i(2, "x")
    }),

    s({
        trig="int(%-?[%a%d]+)to(%-?[%a%d]+)",
        regTrig=true,
        wordTrig=false,
    }, {
        t("\\int\\limits_{"), X(1), t("}"),
        t("^{"), X(2), t("} "),
        i(1, "fn(x)"),
        t(" \\; d"),
        i(2, "x")
    }),

    s({
        trig="oin(%-?[%a%d]+)to(%-?[%a%d]+)",
        regTrig=true,
        wordTrig=false,
    }, {
        t("\\oint\\limits_{"), X(1), t("}"),
        t("^{"), X(2), t("} "),
        i(1, "fn(x)"),
        t(" \\; d"),
        i(2, "x")
    }),

    ms({
        {trig="sum(%a)(%-?%d+)to(%-?%d+)", regTrig=true, wordTrig=false,},
        {trig="sum(%a)(%-?%a+)to(%-?%a+)", regTrig=true, wordTrig=false,},
    }, {
        t("\\sum_{"), X(1), t("="), X(2), t("}"),
        t("^{"),
        X(3), t("} \\; "),
        i(1, "fn(x)"),
    }),

    s({trig="cas", desc=""}, {
        t({"\\begin{cases}", "\t \\; " }),
        i(1), t(" & \\text{"), i(2), t({"} \\\\", "\t \\; "}),
        i(3), t(" & \\text{"), i(4, "otherwise"), t({"}", ""}),
        t({"\\end{cases}", "" })
    }),

    s({trig="(%a)ma", regTrig=true, desc="Matrix"}, {
        t("\\begin"),
        d(1, function(_, snip)
            return sn(nil, {
                t("{" .. snip.captures[1] .. "matrix}"),
            })
        end, {}),
        t({"", "\t"}),
        i(2),
        t({"", "\t"}),
        d(3, repeat_jumpable_matrix_rows, 2, {}),
        t({"", ""}),
        t("\\end"), rep(1),
    }),
}
