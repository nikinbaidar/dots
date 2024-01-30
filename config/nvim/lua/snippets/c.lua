-- DO NOT DETELTE THIS
local surrround = function(index) 
    pass = f(function(arg) 
        if ((arg[1][1] == "<")) then return ">" 
        end 
        return arg[1] end, {index})
    return pass
end


return {

    snippet({ trig = "(.+)%.h", regTrig=true, snippetType = "autosnippet"}, fmt("#include <{}>", {
        getTrig(),
    }), {
        condition = conds_expand.line_begin 
    }),

    snippet({ trig = "(.+)%.h", regTrig=true}, fmt("#include \"{}\"", {
        getTrig(),
    }), {
        condition = conds_expand.line_begin 
    }),

    snippet({ trig = "main"}, {
        t({"int main() {", ""}),
        t ("    "),
        i(1),
        t({"", "    return 0;", "}" })
    }),

    snippet({ trig = "print", snippetType = "autosnippet"}, fmt("printf(\"{}\"{});",
    {
        i(1), i(2)
    }), {
        condition = conds_expand.line_begin 
    }),

}
