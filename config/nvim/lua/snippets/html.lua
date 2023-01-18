local getHeading

getHeading = function(_, snip)
    return snip.trigger
end

return {

    snippet({trig = "h%d", regTrig = true}, fmt("<{}>{}</{}>", {
        f(getHeading, {}),
        i(1, "Heading"),
        f(getHeading, {}),
    })),

}
