return {
    s({trig="def", desc="Function"}, {
        t("def "), i(1), t("("), i(2, "params"), t("):"),
        t({"", "\t",}), i(3),
    }),

    s({trig="wo", desc="with open"}, {
        t("with open("), t("\""), i(1), t("\", \""), i(2), t("\") as f:"),
        t({"", "\t",}), i(3),
    }),

    s({trig="lc", desc="List Comprehension"}, {
        t("["),
        i(1, "exp"),
        t(" for i"),
        t(" in "),
        i(2, "iterable"),
        t("]"),
    }),

}
