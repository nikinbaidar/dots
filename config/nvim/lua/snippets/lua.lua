local luaimport
local trigger

luaimport = function(import_name)
    local parts = vim.split(import_name[1][1], ".", true)
    return parts[#parts] or ""
end

trigger = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t "\"", i(1, "TRIGGER") , t"\"",
            }),
            s(1, {
                t "{{ trig = \"",
                i(1, "TRIGGER"),
                t "\", ",
                i(2, "OPTS"),
                t "}}"
            }),
        })) 
    end, {})
end

return { 

    snippet("snip", fmt('snippet({}, fmt("{}", {{\n\t{}\n}})),\n', {
        trigger(1),
        i(2, "STRING"),
        i(3, "NODES")
    })), 

    snippet("req", fmt([[local {} = require('{}')]], {
        f(luaimport, {1}),
        i(1)
    })),

}
