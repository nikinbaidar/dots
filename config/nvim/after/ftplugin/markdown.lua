--
-- ░█▄█░█▀█░█▀▄░█░█░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█░█░█▀█░█▀▄░█▀▄░█░█░█░█░█▄█░█░█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀


vim.o.spell = true
vim.bo.shiftwidth = 0
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

vim.keymap.set('i', '<C-s>', function()
  require('fzf-lua').fzf_exec('cat /home/nikin/notes/tags.txt', {
    winopts = {
      height = 20,
      width = 80,
    },
    actions = {
      ['default'] = function(selected)
        vim.schedule(function()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { selected[1] .. " " })
          vim.api.nvim_win_set_cursor(0, { row, col + #selected[1] })
          vim.defer_fn(function() vim.cmd('startinsert') end, 5)
        end)
      end
    }
  })
end, { desc = "Pick and insert tag at cursor" })

vim.api.nvim_create_user_command(
  'Table',
  function (args)

    local values = vim.fn.split(args.args, ' ')
    for i, value in ipairs(values) do
      values[i] = tonumber(vim.fn.trim(value))
    end

    local num_rows = values[1]
    local num_cols = values[2]

    if not num_rows or not num_cols then
      vim.api.nvim_err_writeln("Error: args rows & cols missing in Table")
      return
    end

    local table_lines = {
      "|" .. string.rep(" |", num_cols),
      "|" .. string.rep(" - |", num_cols)
    }

    for row = 1, num_rows do
      local cell_line = "|"
      for col = 1, num_cols do
        cell_line = cell_line .. "" ..  " |"
      end
      table.insert(table_lines, cell_line)
    end

    local current_line = vim.fn.line('.')
    vim.fn.append(current_line, table_lines)  
    vim.cmd("normal! j0l")
  end,
  { nargs = "*", bang = true, desc = "Insert a Markdown table of specified rows and columns" }
)


vim.api.nvim_create_user_command(
  'FormatTable',
  "normal! vip :! pandoc -t markdown-simple_tables<CR>",
  {bang = true, desc="titlecase from current point to eol"}
)

vim.keymap.set('v', '<leader>t', '!pandoc -t markdown-simple_tables<CR>',
{ silent = true, desc = 'Align selected md table using pandoc' })


local function split_code_block()
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

  -- Insert after the current line
  vim.api.nvim_buf_set_lines(0, row-1, row-1, false, {
    "```",
    "",
    fence,
  })

  -- Put cursor at the first line of the new code block
  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
end

vim.keymap.set("n", "-", split_code_block, {
  desc = "Split fenced code block",
})


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


local function yank_code_fence()
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

  -- move to window below, paste, enter insert mode at end, add two newlines
  local keys = vim.api.nvim_replace_termcodes(
    '<C-w>w"qpA<CR><C-\\><C-n><C-w>p',
    true, false, true
  )
  vim.api.nvim_feedkeys(keys, "n", false)
end


vim.api.nvim_create_autocmd('BufEnter', {
    pattern = {"*.md", "*.qmd"},
    callback = function()
        vim.keymap.set("n", "<leader>r", yank_code_fence, {
            buffer = true,
            desc = "Send code fence to an ipython session" 
        })
    end,
})

vim.api.nvim_create_user_command("IPython", 
    function()
        vim.cmd("belowright vertical terminal ipython")
        vim.cmd("wincmd p")
    end, {
    desc = "Open IPython in a terminal split below and return to previous window",
})

local function wrap_selection_in_fence()
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

vim.keymap.set('x', '<leader>mf', wrap_selection_in_fence, { desc = 'Wrap selection in markdown fence' })
