return {

    snippet({trig = "h%d", regTrig = true}, fmt("<{}>{}</{}>", {
        getTrig(), i(1, "Heading"), getTrig(),
    })),

}
