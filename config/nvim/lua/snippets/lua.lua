local luaimport

luaimport = function(import_name)
    local parts = vim.split(import_name[1][1], ".", true)
    return parts[#parts] or ""
end

return { 

    snippet("snip", fmt('snippet("{}", fmt("{}", {{\n\t{}\n}})),\n', {
        i(1, "TRIGGER"),
        i(2, "STRING"),
        i(3, "NODES")
    })), 

    snippet("req", fmt([[local {} = require('{}')]], {
        f(luaimport, {1}),
        i(1)
    })),

}
