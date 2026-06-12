return {
     s({ trig = "#inc", autosnippet=true }, {
         t("#include <"),
         i(1),
         t(">"),
     }, {
         condition = conds_expand.line_begin
     }),
}
