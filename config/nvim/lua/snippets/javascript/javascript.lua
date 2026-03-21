return {
    -- DOM Selectors
    --
    s("get", fmt("const {} = {}.{}('{}');", {
        r(2),
        i(3, "document"),
        c(1, { t ("getElementById"), t ("getElementsByClassName") }),
        i(2)
        })
    ),

    s("qs", fmt("let {} = {}.{}('{}');", {
        i(1),
        i(4, "document"),
        c(2, { t("querySelector"), t("querySelectorAll") }),
        i(3, "CSS selector")
        })
    ),

    -- Debugging
    --
    parse("cc", "console.clear()"),

    s("cl", fmt("console.log({});", {
        i(1)
    })),

    -- Functions

    s("=>", fmt([[
    ({}) => {{
        {}
    }}
    ]], {
        i(1), i(2)
    })),

    -- Methods

    parse("cr", "crypto.randomUUID"),

    s("map", fmt([[{}.map({} => {{
        {}
        return {}
    }});
    ]] , {
        i(1, ""),
        c(2, {
            t "item",
            t "(item, index)",
        }),
        i(3),
        i(4),
    })),

    s("exp", fmt("export default {};", {
        i(1)
    })),

    s("com", {
        c(1, {
            sn(1, {
                t "class", t " ",
                i(1, "name"), t " ",
                t({ "extends React.Component {", "\t"}),
                i(2),
                t({ "", "\trender() {", "\t\treturn ",
            }),
            i(3),
            t({"", "\t}", "}"})
        }),

        sn(1, {
            t "function", t " ",
            i(1, "name"), 
            t("("),
            i(2),
            t({") {", "\treturn(",  "\t\t"}),
            i(3),
            t({"",  "\t);", "}"})
        }),
    }), 
    }, { condition = conds_expand.line_begin }
    ),

    s("test", p(os.date, "%Y"))


}
