local M = {}

local keys = vim.api.nvim_replace_termcodes(
    '<C-w>w"qpA<CR><C-\\><C-n><C-w>p',
    true, false, true
)

local function find_enclosing_fence()
    local cur = vim.fn.line(".")
    local total = vim.api.nvim_buf_line_count(0)
    local fences = {}

    for i = 1, total do
        if vim.fn.getline(i):match("^```") then
            table.insert(fences, i)
        end
    end

    for i = 1, #fences, 2 do
        local top, bottom = fences[i], fences[i + 1]
        if bottom and cur >= top and cur <= bottom then
            return top, bottom
        end
    end

    return nil, nil
end


function M.yank_code_fence()
    local top, bottom = find_enclosing_fence()

    if not top then
        vim.notify("Not inside a code fence", vim.log.levels.WARN)
        return
    end

    if bottom - top < 2 then
        vim.notify("Code fence is empty", vim.log.levels.WARN)
        return
    end

    vim.api.nvim_win_set_cursor(0, { top + 1, 0 })
    vim.cmd("normal! V")
    vim.api.nvim_win_set_cursor(0, { bottom - 1, 0 })
    vim.cmd('normal! "qy')

    local reg = vim.fn.getreg("q")
    if not reg:match("\n\n$") then
        vim.fn.setreg("q", reg .. "\n")
    end

    vim.api.nvim_feedkeys(keys, "n", false)
end


function M.split_code_block()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  -- Find the nearest previous opening fence
  local fence
  for i = row, 1, -1 do
    if lines[i]:match("^```") then
      fence = lines[i]
      break
    end
  end

  if not fence then
    vim.notify("No code fence found", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(0, row-1, row-1, false, {
    "```",
    "",
    fence,
  })

  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
end


function M.wrap_selection_in_fence()
    -- exit visual mode so marks '< and '> are set
    vim.cmd('normal! \27')  -- <Esc>

    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2] - 1  -- 0-indexed
    local end_line = end_pos[2] - 1

    vim.ui.input({ prompt = 'Language: ', default = "python" }, function(lang)
        if lang == nil then
            lang = ""
        end

        local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

        local fenced = { '```' .. lang }
        vim.list_extend(fenced, lines)
        table.insert(fenced, '```')

        vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, fenced)
    end)
end


function M.copy_code_fences()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local blocks = {}
    local current_block = nil
    local in_fence = false

    for _, line in ipairs(lines) do
        local fence_open = line:match("^%s*```{?[%w_-]*}?%s*$")

        if not in_fence and fence_open then
            in_fence = true
            current_block = {}
        elseif in_fence and line:match("^%s*```%s*$") then
            in_fence = false
            table.insert(blocks, table.concat(current_block, "\n"))
            current_block = nil
        elseif in_fence then
            -- skip lines that are just plt.show() (allowing surrounding whitespace)
            if not line:match("^%s*plt%.show%(%)%s*$") then
                table.insert(current_block, line)
            end
        end
    end

    if #blocks == 0 then
        vim.notify("No code fences found in this file.", vim.log.levels.WARN)
        return
    end

    local result = table.concat(blocks, "\n")

    -- Only append plt.close('all') if matplotlib is actually imported somewhere
    local uses_matplotlib = result:match("import%s+matplotlib")
    or result:match("from%s+matplotlib")
    or result:match("import%s+matplotlib%.pyplot%s+as%s+plt")

    if uses_matplotlib then
        result = result .. "\nplt.close('all')\n"
    end

    vim.fn.setreg("+", result)
    vim.fn.setreg('"', result)

    vim.notify(("Copied code from %d fence(s) to clipboard."):format(#blocks))
end



return M
