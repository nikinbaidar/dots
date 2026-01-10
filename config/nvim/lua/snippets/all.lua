
return {
    s({trig="date", desc="Insert today's date"}, {
        t(os.date('%Y-%m-%d'))
    }),

    s({trig="#!([%l%d]+)", regTrig=true, desc="Shebang `#! interpreter [one-arg-only]`"}, {
        t("#!/usr/bin/env"),
        t(" "),
        C()
    }), 

}
