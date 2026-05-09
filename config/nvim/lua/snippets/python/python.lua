return {

    s({trig="wo", desc="with open"}, {
        t("with open("), t("\""), i(1), t("\", \""), i(2), t("\") as f:"),
        t({"", "\t",}), i(3),
    }),

    ms({ "doc", "docstr", }, {
        t({"\"\"\"", ""}),
        i(1),
        t({"", "\"\"\""}),
    }),

    s("main", fmta([[
    def main():
        <>


    if __name__ == "__main__":
        main()
    ]], {
        i(1, "pass"),
    })),
}
