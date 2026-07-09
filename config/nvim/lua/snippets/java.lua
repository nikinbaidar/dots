local function lowercase(args)
    return sn(nil, t(string.lower(args)))
end

return {
     s({ trig = "if", }, {
         t("if ("), i(1), t({") {", "\t"}),
         i(2),
         t({"", "}"})
     }),

     s({ trig = "for", }, {
         t("for ("),
         i(1),
         t({") {", "\t"}),
         i(2),
         t({"", "}"})
     }),

     s({ trig = "while", }, {
         t("while ("),
         i(1),
         t({") {", "\t"}),
         i(2),
         t({"", "}"})
     }),

     s({ trig = "print", }, {
         t("System.out.print("),
         i(1),
         t(");"),
     }),

     s({ trig = "println", }, {
         t("System.out.println("),
         i(1),
         t(");"),
     }),

     s({ trig="psvm"}, {
         t("public static void main(String[] args) {"),
         t({"", "\t"}),
         i(1),
         t({"", "}"}),
     }),

     s({ trig = "hashmap"}, {
         t("HashMap<"), i(1), t("> "), 
         i(2),
         t(" = new HashMap<>();"),
     }),

     s({ trig = "list"}, {
         t("List<"), i(1), t("> "), 
         i(2),
         t(" = new ArrayList<>();"),
     }),

     s({ trig = "set"}, {
         t("Set<"), i(1), t("> "), 
         i(2),
         t(" = new HashSet<>();"),
     }),

     s({trig = "object"}, {
         i(1, "ClassName"),
         t(" "),
         d(2, function(args) 
                 return sn(nil, { i(1, args[1][1]:lower()), }) 
             end, {1}),
         t(" = new "),
         rep(1),
         t("();"),
     }),

}
