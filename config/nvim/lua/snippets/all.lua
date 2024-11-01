local lorem 
local date
local shebang

lorem = [[
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
]]

date = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t(os.date('%Y-%m-%d')), i(1)
            }),
            s(1, {
                t(os.date('%Y-%m-%d %H:%M:%S')), i(1)
            }),
        })) 
    end, {})
end


return {

    parse({
        trig = "lorem", snippetType = "autosnippet"
    }, lorem),

    snippet("date", fmt("{}", date(1))),

    snippet("same", fmt("example: {}, reproducedhere: {}", {
        i(1),
        r(1)
    })),

    snippet("#!", fmt("#!/{} {}", {
        c(1, { 
            t "bin/bash", 
            t "usr/bin/env",
        }),
        i(2), 
    })), 

    snippet({
        trig = "helloworld",
        snippetType = "autosnippet"
    }, {
        t("Hello, World!")
    }), 


}



