local renderer = function(index)
    return d(index, function(arg)
        if getChoice(arg) == "" then
            return sn(nil, sn(1, {
                t({"() {", "\treturn(", "\t\t<>", "\t\t"}),
                i(1),
                t({"", "\t\t</>", "\t);", "}"})
            }))
        end
        return sn(nil, sn(1, {
            t({"(", "\t<>", "\t"}),
            i(1),
            t({"", "\t</>", ")"}),
        }))
    end, {1}) -- Node where type of rendering is specified.
end


return {

    parse("ird", "import ReactDOM from 'react-dom/client'"),

    s("lazy", fmt("{}: lazy(() => import('./{}')),", {
        i(1, "Filename"),
        r(1),
    })),

    s("cdm", fmt([[
    componentDidMount({}) {{
        {}
    }};
    ]], { i(1), i(2) })),

    s("cdup", fmt([[
    componentDidUpdate({}) {{
        {}
    }};
    ]], { i(1), i(2) })),

    s("cwm", fmt([[
    componentWillMount({}) {{
        {}
    }};
    ]], { i(1), i(2) })),

    s("cwr", fmt([[
    componentWillReceiveProps(nextProps) {{
        {}
    }};
    ]], { i(1) })),

    s("cwu", fmt([[
    componentWillUnmount({}) {{
        {}
    }};
    ]], { i(1), i(2) })),

    s("cwup", fmt([[
    componentWillUpdate({}) {{
        {}
    }};
    ]], { i(1), i(2) })),

    -- Props

    s("tp", fmt("this.props.{}", { i(1) })),

    s("elem", fmt([[
    const elem = {{
        {}
    }};
    ]], {
        i(1)
    })),

    s("com", {
        c(1, {
            sn(1, {
                t "class", t " ",
                i(1, "name"), t " ",
                t({ "extends React.Component {", "\t"}),
                i(2),
                t({ "", "\trender() {", "\t\treturn " }),
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
    }, {
        condition = conds_expand.line_begin
    }),

    s("rf", fmt([[
    <React.Fragment>
    {}
    </React.Fragment>
    ]], {
        i(1)
    })),

    s("ren", fmt("{}render{}", {
        c(1, {
            t "",
            sn(1, { i(1, "root"), t "." }),
        }),
        renderer(2),
    })),

}
