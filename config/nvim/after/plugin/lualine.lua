--
-- ░█░░░█░█░█▀█░█░░░▀█▀░█▀█░█▀▀
-- ░█░░░█░█░█▀█░█░░░░█░░█░█░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = {'', ''},
        globalstatus = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = { {'branch', icon=''}, 'filename', 'diff', 'diagnostics'},
        lualine_c = {''},
        lualine_x = {'encoding', 'fileformat', {'filetype', colored = false, icon_only = false}},
        lualine_y = {'location', 'progress'},
        lualine_z = {''},
    },
}
