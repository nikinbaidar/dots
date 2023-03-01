local renderer = function(rendering)
    return d(rendering, function(arg)
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

    snippet("gid", fmt("{}.getElementById('{}')", {
        i(1, "parent"),
        i(2, "id"), 
    })),

    snippet("gic", fmt("{}.getElementsByClassName('{}')", {
        i(1, "parent"),
        i(2, "className"), 
    })),

    snippet("qs", fmt("{}.querySelector('{}')", {
        i(1, "parent"),
        i(2, "className"), 
    })),

    snippet("frag", fmt([[
    <>
    {}
    </>
    ]], {
        i(1)
    })),

    snippet("crn", fmt([[
    render() {{
        return (
            <>
            {}
            </>
        );
    }}
    ]], {
        i(1)
    })),

    snippet("ren", fmt("{}render{}", {
        c(1, { t "", s(1, { i(1, "root"), t "." }), }),
        renderer(2),
    })),

}
