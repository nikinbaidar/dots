return({
    s({trig="insert", desc="insert"}, {
        t("db."),
        i(1),
        t".",
        c(2, {
            t"insertOne(",
            t"insertMany(",
        }),
        i(3),
        t")",
    }),

    s({trig="find", desc="find"}, {
        t("db."),
        i(1),
        t".",
        c(2, {
            t"find(",
            t"findMany(",
        }),
        i(3),
        t")",
    }),

    s({trig="update", desc="update"}, {
        t("db."),
        i(1),
        t".",
        c(2, {
            t"updateOne(",
            t"updateMany(",
        }),
        i(3),
        t")",
    }),

    s({trig="delete", desc="delete"}, {
        t("db."),
        i(1),
        t".",
        c(2, {
            t"deleteOne(",
            t"deleteMany(",
        }),
        i(3),
        t")",
    }),
})
