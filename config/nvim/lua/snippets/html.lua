return {
    s({trig="h[1-6]", regTrig=true, snippetType="autosnippet", desc="Headers <<h1>$1</h1>"}, {
        t("<"), T(), t(">"), i(1), t("</"), T(), t(">")
    }),
}
