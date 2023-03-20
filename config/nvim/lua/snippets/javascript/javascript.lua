return {
    -- DOM Selectors
    --
    snippet("get", fmt("const {} = {}.{}('{}');", {
        r(2),
        i(3, "document"),
        c(1, { t ("getElementById"), t ("getElementsByClassName") }),
        i(2)
        })
    ),

    snippet("qs", fmt("let {} = {}.{}('{}');", {
        i(1),
        i(4, "document"),
        c(2, { t("querySelector"), t("querySelectorAll") }),
        i(3, "CSS selector")
        })
    ),

    -- Debugging
    --
    parse("cc", "console.clear()"),

    snippet("cl", fmt("console.log({});", {
        i(1)
    })),

    -- Functions

    snippet("=>", fmt([[
    ({}) => {{
        {}
    }}
    ]], {
        i(1), i(2)
    })),

    -- Methods

    parse("cr", "crypto.randomUUID"),

    snippet("map", fmt([[{}.map({} => {{
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

    snippet("exp", fmt("export default {};", {
        i(1)
    })),

    snippet("com", {
        c(1, {
            s(1, {
                t "class", t " ",
                i(1, "name"), t " ",
                t({ "extends React.Component {", "\t"}),
                i(2),
                t({ "", "\trender() {", "\t\treturn ",
            }),
            i(3),
            t({"", "\t}", "}"})
        }),

        s(1, {
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

    snippet("test", p(os.date, "%Y"))


}
