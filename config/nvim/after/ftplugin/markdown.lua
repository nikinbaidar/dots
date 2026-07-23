#!/usr/bin/env lua

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


local D = require("utils.datascience")

vim.keymap.set('n', '<leader>r', D.yank_code_fence, { desc="Send code fence to console", buffer=true })
vim.keymap.set('v', '<leader>r', D.run_selection , { desc="Send visual selection to console", buffer=true })
vim.keymap.set('n', '-', D.split_code_block, { desc="Split fenced code block", buffer=true })
vim.keymap.set('x', '+', D.wrap_selection_in_fence, { desc="Wrap selection inside a code fence", buffer=true })
