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

date = function() 
    return {os.date('%Y-%m-%d')} 
end


shebang = function() 
    if vim.bo.filetype == "sh" then
        return { "#!/bin/bash" }
    end
    return { "#!/usr/bin/env "  .. vim.bo.filetype }
end

return {

    parse({
        trig = "lorem", snippetType = "autosnippet"
    }, lorem),

    snippet("date", {
        f(date, {})
    }),

    snippet("same", fmt("example: {}, reproducedhere: {}", {
        i(1),
        r(1)
    })),

    snippet("#!", {
        f(shebang, {})
    }),

    snippet({
        trig = "helloworld",
        snippetType = "autosnippet"
    }, {
        t("Hello, World!")
    }), 


}
