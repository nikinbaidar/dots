local date
local links
local getModel
local getUpstreamURL
local getSite
local getAddress

date = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, {
                t(os.date('%Y-%m-%d')), i(1)
            }),
            s(1, {
                i(1, 'YYYY'), t "-",
                i(2, 'MM'), t "-",
                i(3, 'DD')
            }),
        })) 
    end, {})
end


links = function(index)
    return d(index, 
    function() 
        return s(nil, c(1, {
            s(1, { i(1, "url")}),
            s(1, { t "https://www.", i(1, "url"), t ".com" }),
            s(1, { t "/",  i(1, "relative URL") }),
        })) 
    end, {})
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


getURL = function(index) 

    local getModel
    local isModel

    getModel = function(arg)
        return arg[1][1]
    end

    isSModel = function(str)
        return str == model
    end

    return d(index, function(arg) 

        local url_list

        model = getModel(arg)

        url_list = {
            ["Selectra Pro M"] = "https://www.elitechgroup.com/product/selectra-pro-m",
        }

        if (type(url_list[model]) == "string") then
            return s(nil, t(url_list[model]))
        else
            return s(nil, t(""))
        end

    end, {3}) -- Node where model is specifed
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
                t "Blue Cross Hospital",
                t "KMC",
                t "National Trauma Center",
                t "Pratham Pathology",
                t "Star Hospital",
                t "Tesla Diagnostic Clinic",
            }))
        elseif isModel("Selectra Pro S") then
            return s(nil, c(1, {
                t "Ananda Ban Leprosy Hospital",
                t "International Friendship Children's Hospital",
                t "Kathmandu PathLab and Diagnostic Center",
                t "Nepal Lab House",
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
            ["Aarus LifeStyle Hospital"] = "Pulchwok, Lalitpur",
            ["Ananda Ban Leprosy Hospital"] = "Lele, Lalitpur",
            ["Blue Cross Hospital"] = "Tripureshwor, Kathmandu",
            ["International Friendship Children's Hospital"] = "Panipokhari, Lazimpat, Kathmandu",
            ["Kathmandu PathLab and Diagnostic Center"] = "Maharjgunj, Kathmandu",
            ["KMC"] = "Sinamangal, Kathmandu",
            ["National Trauma Center"] = "Mahankal, RNAC, Kathmandu",
            ["Nepal Lab House"] = "Pinglastahn, Gaushala, Kathmandu",
            ["Pratham Pathology"] = "Panipokhari, Lazimpat, Kathmandu",
            ["Siddhi Memorial Hospital"] = "Suryabinayak, Bhaktapur",
            ["Star Hospital"] = "Sanepa Height, Lalitpur",
            ["Tesla Diagnostic Clinic"] = "Baluwatar, Kathmandu",
            ["Valley Nursing Home"] = "Putalisadak, Kathmandu",
        }

        if (type(address_list[site]) == "string") then
            return s(nil, t(address_list[site]))
        else
            return s(nil, t(site))
        end

    end, {5}) -- Node where site is specifed
end

return {

    snippet("**", fmt("**{}**",  {
        i(1, "BOLD TEXT"),
    })),

    snippet("_", fmt("_{}_",  {
        i(1, "ITALIC TEXT"),
    })),

    snippet("sec", fmt("## {}",  {
        i(1, "Section"),
    })),

    snippet("sub", fmt("### {}", {
        i(1, "Sub Section"),
    })),

    snippet("ssub", fmt("#### {}", {
        i(1, "Sub Sub Section"),
    })),

    snippet("link", fmt("[{}]({})", {
        i(1, "Anchor"),
        links(2)
    })),

    snippet("cbl", fmt("```{}\n{}\n```", {
        i(1),
        i(2),
    })),

    snippet("ilc", fmt("`{}`", {
        i(1)
    })),

    snippet("log", fmt([[
    ```
    Date : {}
    Brand: {}
    Model: {}
    Age  : {}
    Site : {}
    Addr : {}
    Rem  : {}
    ```

    - {}

    - {}

    - {}

    - {}
    ]], {
        date(1),
        c(2, {
            t "ELITechGroup",
            t "Trinity Biotech",
        }), getModel(3),
        i(4, "YSI"), -- Years since installation
        getSite(5), getAddress(6),
        c(7, {
            t "Corrective Maintenance",
            t "Preventive Maintenance",
            t "Installation",
        }),
        i(8, "DESCRIPTION OF PROBLEM"),
        i(9, "ANALYSIS OF PROBLEM"),
        i(10, "FINAL SOLUTION"),
        i(11, "NOTES"),
    })),

}
