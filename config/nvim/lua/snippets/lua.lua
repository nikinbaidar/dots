local function luaimport(import_name)
    local parts = vim.split(import_name[1][1], ".", true)
    return parts[#parts] or ""
end


local function trigger(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t "\"", i(1, "TRIGGER") , t"\"",
            }),
            s(1, {
                t "{ trig = \"",
                i(1, "TRIGGER"),
                t "\", ",
                i(2, "OPTS"),
                t "}"
            }),
        })) 
    end, {})
end


return { 

    snippet("snip", fmt([[
    snippet({snippet_trigger}, fmt({snippet_str}, {{
        {}
    }})), 
    ]], {
        snippet_trigger = trigger(1),
        snippet_str = c(2, {
            s(1, {t("\""), i(1), t("\"")}),
            s(2, {t("[["), i(1), t("]]")}),
        }),
        i(3, "NODES"),
    }), {
        condition = conds_expand.line_begin 
    }), 

    snippet("req", fmt("local {} = require('{}')", {
        f(luaimport, {1}),
        i(1)
    })),

    snippet("match", {
        i(1, "sample_text"),
        t(": "),
        m(1, "%d", "contains a number", "no number :("),
    }),

    -- Return whats fed into if number of input chars is even.
    snippet("match", {
        i(1, { "sample_text" }),
        t(": "),
        m(1, function(args)
            return (#args[1][1] % 2 == 0 and args[1]) or nil
        end),
    }),

    snippet({
        trig = "mailto",
        snippetType = "autosnippet"
    }, {
        t("mailto:"),
		i(1),
		m(2, "[n][i][k][i][n]", "baidarr@gmail.com"),
	}),
}
