local renderer = function(index)
    return d(index, function(arg)
        if getChoice(arg) == "" then
            return s(nil, s(1, {
                t({"() {", "\treturn(", "\t\t<>", "\t\t"}),
                i(1),
                t({"", "\t\t</>", "\t);", "}"})
            }))
        end
        return s(nil, s(1, {
            t({"(", "\t<>", "\t"}),
            i(1),
            t({"", "\t</>", ")"}),
        }))
    end, {1}) -- Node where type of rendering is specified.
end


return {

    parse("ird", "import ReactDOM from 'react-dom/client'"),


    -- Lifecycle Methods
    
    snippet("cdm", fmt([[
    componentDidMount({}) {{
        {}
    }}; 
    ]], { i(1), i(2) })),

    snippet("cdup", fmt([[
    componentDidUpdate({}) {{
        {}
    }}; 
    ]], { i(1), i(2) })),

    snippet("cwm", fmt([[
    componentWillMount({}) {{
        {}
    }}; 
    ]], { i(1), i(2) })),

    snippet("cwr", fmt([[
    componentWillReceiveProps(nextProps) {{
        {}
    }}; 
    ]], { i(1) })),

    snippet("cwu", fmt([[
    componentWillUnmount({}) {{
        {}
    }}; 
    ]], { i(1), i(2) })),

    snippet("cwup", fmt([[
    componentWillUpdate({}) {{
        {}
    }}; 
    ]], { i(1), i(2) })),

    -- Props 
    
    snippet("tp", fmt("this.props.{}", { i(1) })),

    snippet("elem", fmt([[
    const elem = {{
        {}
    }};
    ]], {
        i(1)
    })),

    snippet("com", {
        c(1, {
            s(1, {
                t "class", t " ",
                i(1, "name"), t " ",
                t({ "extends React.Component {", "\t"}),
                i(2),
                t({ "", "\trender() {", "\t\treturn " }),
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
    }, {
        condition = conds_expand.line_begin 
    }),

    snippet("rf", fmt([[
    <React.Fragment>
    {}
    </React.Fragment>
    ]], {
        i(1)
    })),

    snippet("ren", fmt("{}render{}", {
        c(1, {
            t "", 
            s(1, { i(1, "root"), t "." }), 
        }),
        renderer(2),
    })),

}
