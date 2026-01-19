--
-- ░▀█▀░█▀▀░█░█░░░░█░░░█░█░█▀█
-- ░░█░░█▀▀░▄▀▄░░░░█░░░█░█░█▀█
-- ░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀


vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2


local function is_tty()
    return vim.fn.exists('$TERM_PROGRAM') == 0
end

local function RunLuaLaTeX()
    -- pass
end

local function ViewPDF()
    -- WARN: This won't work if tmux is running in tty.
    local pdfpath = " " .. vim.fn.expand('%:r') .. ".pdf"
    if is_tty() then
        vim.api.nvim_command("below term pdf2txt" ..  pdfpath)
    else
        vim.api.nvim_command("silent ! sioyek" .. pdfpath)
    end
end

vim.b.spell = true

vim.keymap.set('n', '<leader>v', ViewPDF, {silent=true, desc="View complied pdf"})

vim.api.nvim_create_user_command(
    'AddBibliography',
    function()
        vim.api.nvim_command("! clear ; biber %:r")
        vim.api.nvim_command("silent call RunLatex()")
    end, {
    bang = true,
    desc = "Add bibliography to tex docs",
})

vim.api.nvim_create_autocmd({'BufEnter'}, {
    pattern = '*.tex',
    command = 'nnoremap <leader>r :call RunLatex()<CR>'
})
