-- DO NOT DETELTE THIS
local surrround = function(index) 
    pass = f(function(arg) 
        if ((arg[1][1] == "<")) then return ">" 
        end 
        return arg[1] end, {index})
    return pass
end


return {

    snippet({ trig = "(.+)%.h", regTrig=true, snippetType = "autosnippet"}, fmt("#include <{}>{}", {
        trigger(),
        t({"", ""}),
    }), {
        condition = conds_expand.line_begin 
    }),

    snippet({ trig = "(.+)%.h", regTrig=true}, fmt("#include \"{}\"", {
        trigger(),
    }), {
        condition = conds_expand.line_begin 
    }),

    snippet({ trig = "main"}, {
        t({"int main() {", ""}),
        t ("    "),
        i(1),
        t({"", "    return 0;", "}" })
    }),

    snippet({ trig = "print" }, fmt("printf(\"{}\"{});", { i(1), i(2) }), {}),

}
