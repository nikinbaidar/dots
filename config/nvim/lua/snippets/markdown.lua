local function L(index)
    return d(index, function(_, snip)
        local trigger = snip.captures[1]
        local lang_map = {
            py = "python",
            js = "javascript",
            sh = "bash",
            sqlx = "{sql, connection=con}"
        }
        local lang = lang_map[trigger] or trigger
        return sn(nil, {t(lang)})
    end, {})
end

local function recursive_tag()
    return sn(nil, c(1, {
        t("% Press <C-l><C-s> to add a tag"),
        sn(nil, {
            t("- "),
            i(1),
            t({"", "\t"}),
            d(2, recursive_tag, {}),
        }),
    }))
end

return {

    s({
        trig = "cbl(%a*)",
        regTrig=true,
        desc="Language [Executable] Code block",
    }, {
        c(1, {
            t("```"),
            t("```{"),
        }),
        L(2),
        m(1, "```{", "}", ""),
        t({"", ""}),
        i(3),
        t({"", ""}),
        t({"```", ""}),
        i(4),
    }),

    s({trig="randdate", desc="Insert a random date between 2019-2026"}, {
        t(io.popen('date -d "2019-01-01 + $((RANDOM % 2192)) days" "+%Y-%m-%d"'):read("*l"))
    }),

    s("yaml", {
        t({"---", ""}),
        t("title: \""),
        i(1),
        t({"\"", ""}),
        t({"tags:", "\t"}),
        d(2, recursive_tag),
        t({"", "date: "}),
        i(3),
        t({"", "---", ""})
    }),

}
