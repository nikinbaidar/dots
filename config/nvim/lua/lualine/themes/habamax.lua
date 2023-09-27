local habamax = {}

local colors = {
    black     = '232323',
    white     = '#ecf0c1',
    green     = '#87AF87', 
    red       = '#D75F5F',
    blue      = '#87AFD7',
    purple    = '#ff0000',
    yellow    = '#af875f',
    gray      = '#9E9E9E',
    darkgray  = '#3a3a3a',
    lightgray = '#c1c3cc'
}

habamax.normal = {
    -- gui parameter is optional and behaves the same way as in vim's highlight command
    a = {bg = colors.gray, fg = colors.black, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.lightgray},
    c = {bg = colors.black, fg = colors.lightgray}
}

habamax.insert = {
    a = {bg = colors.green, fg = colors.black, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.lightgray},
    c = {bg = colors.black, fg = colors.lightgray}
}

habamax.visual = {
    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.lightgray},
    c = {bg = colors.black, fg = colors.lightgray}
}

habamax.replace = {
    a = {bg = colors.purple, fg = colors.black, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.lightgray},
    c = {bg = colors.black, fg = colors.lightgray}
}

habamax.command = {
    a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.lightgray},
    c = {bg = colors.black, fg = colors.lightgray}
}

-- you can assign one colorscheme to another, if a colorscheme is
-- undefined it falls back to normal
habamax.terminal = habamax.normal

habamax.inactive = {
    a = {bg = colors.black, fg = colors.lightgray, gui = 'bold'},
    b = {bg = colors.black, fg = colors.lightgray},
    c = {bg = colors.black, fg = colors.lightgray}
}

-- lualine.theme = habamax
return habamax
