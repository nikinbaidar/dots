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

    s("e-", fmt("{}", {
        t("$e^-$")
    })),

}
