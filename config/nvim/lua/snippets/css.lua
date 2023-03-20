colors = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t "#", i(1, "000") 
            }),
            s(1, {
                i(1, "black") 
            }),
            s(1, {
                t "rgb(",
                i(1, "0"), t ", ",
                i(2, "0"), t ", ",
                i(3, "0"),
                t ")"
            }),
            s(1, {
                t "rgba(",
                i(1, "0"), t ", ",
                i(2, "0"), t ", ",
                i(3, "0"), t ", ",
                i(4, "0"),
                t ")",
            }),
        })) 
    end, {})
end


directions = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            i(1, "all"),
            s(1, {
                i(1, "top-bottom"), t(" "),
                i(2, "left-right"),
            }),
            s(1, {
                i(1, "top"), t(" "),
                i(2, "left-right"), t(" "),
                i(3, "bottom"),
            }),
            s(1, {
                i(1, "top"), t(" "),
                i(2, "left"), t(" "),
                i(3, "bottom"), t(" "),
                i(4, "right"),
            }),
        })) 
    end, {})
end

selectors = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t("#"),
                i(1, "div-name"),

            }),
            s(1, {
                t("."),
                i(1, "class-name"),
            }),
            i(1, "element"),
            s(1, {
                i(1, "first"),
                t("::"),
                i(2, "final")
            }),

        })) 
    end, {})
end

return {

    snippet("s", fmt("{} {{\n\t{}\n}}\n", {
        selectors(1),
        i(2, "CSS")
    })),

    snippet("c", fmt("{}: {};", {
        c(1, {
            t "color",
            t "background-color"
        }),
        colors(2)
    })),

    snippet("p", fmt("{}: {};",  {
        c(1, { 
            t "padding", 
            t "padding-top",
            t "padding-left",
            t "padding-right",
            t "padding-bottom",
        }),
        directions(2)
    })), 

    snippet("m", fmt("{}: {};",  {
        c(1, { 
            t "margin", 
            t "margin-top",
            t "margin-left",
            t "margin-right",
            t "margin-bottom",
        }),
        directions(2)
    })), 

    snippet("b", fmt("{}: {} {} {};", {
        c(1, { 
            t "border", 
            t "border-top",
            t "border-left",
            t "border-right",
            t "border-bottom",
        }),
        i(2, "1px"), 
        i(3, "solid"), 
        colors(4)
    })), 

}
