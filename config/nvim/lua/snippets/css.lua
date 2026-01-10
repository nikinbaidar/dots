local docs = {

important = [[
`!important` is a declaration modifier that overrides the normal cascade and
specificity rules. When a property is marked !important, it is promoted to
the highest priority tier in the cascade.

Syntax:

`property: value !important;`

Notes: `!important` must be declared before the semi-colon.
]],

parameter = "value",

height = [[
The height property sets the height of an element.

Syntax:

`height: auto|numeric|initial|inherit;`

Notes:

1. The min-height and max-height properties override the height property.
2. The height of an element does not include padding, borders, or margins.
]],

width = [[
The width property sets the width of an element.

Syntax:

`width: auto|numeric (px, r[em], %)|initial|inherit;`
]]
}

local function color(index)
  return d(index, function()
    return sn(nil, c(1, {
      sn(1, {t"#", i(1)}),
      i(1, "black"),
      sn(1, {t"rgb(", i(1), t")"}),
      sn(1, {t"rgba(", i(1), t")"}),
      sn(1, {t"hsl(", i(1), t")"}),
    }))
  end, {})
end

return {
    parse({trig="!imp", desc={docs["important"]}}, "!important"),

    s({trig="([#.])([%a%d-]+)", regTrig=true,  desc="CSS block for HTML id/class selector."}, {
        T(), t" ",
        i(1),
        t{"{", "\t"}, i(2), t{"", "}"}, i(3),
    }),

    s({trig="c", desc = "color: <value>;  <value> can be cycled." }, {
        t("color : "),
        color(1),
        t(";")
    }),

    s({trig="bgc", desc = "color: <value>;  <value> can be cycled." }, {
        t("background-color : "),
        color(1),
        t(";")
    }),

    s({trig="h", desc=docs["height"] }, {
        t("height : "),
        i(1, "auto"),
        c(2, {
            m(1, "%d", "em"),
            i(1)
        }),
        t(";")
    }),

    s({trig="w", desc=docs["width"] }, {
        t("width : "),
        i(1, "auto"),
        c(2, {
            m(1, "%d", "em"),
            i(1)
        }),
        t(";")
    }),

    s({trig="p", desc = "padding" },  {
        t("padding : "), i(1), t(";")
    }),

    s({trig="b", desc = "border" }, {
        t("border : "), i(1), t(";")
    }),



}
