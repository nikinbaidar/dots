return {
    s({trig="phasor(%d+)", regTrig=true, desc="Scalable Steinmetz phasor symbol"}, {
        t("\\phase{"),
        C(),
        t("}"),
    }),

    parse({trig="jw", desc=""}, "j\\omega "),




}
