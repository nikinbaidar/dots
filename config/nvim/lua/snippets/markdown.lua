local date
local getModel
local getSite
local getAddress

date = function() 
    return {os.date('%Y-%m-%d')} 
end

getModel = function(index) 

    local getBrand
    local isBrand

    getBrand = function(arg)
        return arg[1][1]
    end

    isBrand = function(str)
        return str == brand
    end

    return d(index, function(arg) 

        brand = getBrand(arg)

        if isBrand("ELITechGroup") then
            return s(nil, c(1, {
                t "Selectra Pro M",
                t "Selectra Pro S",
                t "Selectra Mach 5",
            }))
        elseif isBrand("Trinity Biotech") then
            return s(nil, t "Premier Hb9210")
        else
            return s(nil, t((brand)))
        end
    end, {2}) -- Node where brand is specifed
end


getSite = function(index) 

    local getModel
    local isModel

    getModel = function(arg)
        return arg[1][1]
    end

    isModel = function(str)
        return str == model
    end

    return d(index, function(arg) 

        model = getModel(arg)

        if isModel("Selectra Pro M") then
            return s(nil, c(1, {
                t "Star Hospital",
                t "Blue Cross Hospital",
                t "National Trauma Center",
                t "Pratham Pathology",
                t "Tesla Diagnostic Clinic",
                t "KMC",
            }))
        elseif isModel("Selectra Pro S") then
            return s(nil, c(1, {
                t "Nepal Lab House",
                t "Kathmandu PathLab",
                t "Siddhi Memorial Hospital",
                t "Valley Nursing Home",
            }))
        elseif isModel("Selectra Mach 5") then
            return s(nil, t "Star Hospital")
        elseif isModel("Premier Hb9210") then
            return s(nil, t "Aarus LifeStyle Hospital")
        else
            return s(nil, t((model)))
        end
    end, {3}) -- Node where Model is specifed
end


getAddress = function(index) 

    local getSite
    local isSite

    getSite = function(arg)
        return arg[1][1]
    end

    isSite = function(str)
        return str == site
    end

    return d(index, function(arg) 

        local address_list

        site = getSite(arg)

        address_list = {
            ["Blue Cross Hospital"]      = "Tripureshwor, Kathmandu",
            ["Tesla Diagnostic Clinic"]  = "Baluwatar, Kathmandu",
            ["Valley Nursing Home"]      = "Putalisadak, Kathmandu",
            ["National Trauma Center"]   = "Mahankal, Kathmandu",
            ["Pratham Pathology"]        = "Lazimpat, Kathmandu",
            ["Nepal Lab House"]          = "Pinglastahn, Gaushala, Kathmandu",
            ["Kathmandu PathLab"]        = "Maharjgunj, Kathmandu",
            ["Star Hospital"]            = "Sanepa Height, Lalitpur",
            ["KMC"]                      = "Sinamangal, Lalitpur",
            ["Aarus LifeStyle Hospital"] = "Pulchwok, Lalitpur",
            ["Siddhi Memorial Hospital"] = "Suryabinayak, Bhaktapur",
        }

        if (type(address_list[site]) == "string") then
            return s(nil, t(address_list[site]))
        else
            return s(nil, t(site))
        end

    end, {5}) -- Node where site is specifed
end

return {

    snippet("sec", fmt("## {}",  {
        i(1, "Section"),
    })),

    snippet("sub", fmt("### {}", {
        i(1, "Sub Section"),
    })),

    snippet("link", fmt("[{}]({})", {
        i(1, "Anchor"),
        i(2, "URL"),
    })),

    snippet("c", fmt("```{}\n{}\n```", {
        i(1),
        i(2),
    })),

    snippet("log", fmt([[
    ```
    Date         : {}
    Brand        : {}
    Model        : {}
    Upstream URL : {}
    Site         : {}
    Address      : {}
    Remarks      : {}
    ```

    - {}

    - {}

    - {}

    - {}

    - {}
    ]], {
        c(1, {
            f(date, {}),
            i(1),
        }),
        c(2, {
            t "ELITechGroup",
            t "Trinity Biotech",
        }),
        getModel(3),
        i(4),
        getSite(5),
        getAddress(6),
        i(7),
        i(8,  "DESCRIPTION OF THE PROBLEM"),
        i(9,  "REVISION NOTES"),
        i(10, "CHECKLIST"),
        i(11, "SUSPICIONS"),
        i(12, "FINAL SOLUTION"),
    })),

}
