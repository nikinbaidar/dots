-- ░█░░░█░█░█▀█░█░░░▀█▀░█▀█░█▀▀
-- ░█░░░█░█░█▀█░█░░░░█░░█░█░█▀▀
-- ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
--
require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'spaceduck',
        section_separators = {'', ''},
        globalstatus = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = { 'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', {'filetype', colored = false, icon_only = true}},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
}
