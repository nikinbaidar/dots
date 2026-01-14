
return {
    parse({trig="hlw", desc=""}, "Hello, World!"),

    s({trig="date", desc="Insert today's date"}, {
        t(os.date('%Y-%m-%d'))
    }),

    s({trig="#!([%l%d]+)", regTrig=true, desc="Shebang `#! interpreter [one-arg-only]`"}, {
        t("#!/usr/bin/env"),
        t(" "),
        C()
    }), 

    ms({ -- multi trigger
        "trig1", {trig = "trig2", snippetType = "autosnippet"},
    }, {t"a or b"}),

}
