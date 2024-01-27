#!/usr/bin/env lua

local telescope

telescope = require('telescope')

telescope.setup {
  defaults = {
      layout_config = {
          width=0.95,
      },
      prompt_prefix = '    ',
      file_ignore_patterns = { '.git', 'pdf', 'node_modules' },
  },
  pickers = {
      find_files = {
          cwd = "~/",
      },
  },
  extensions = {
      fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          files = 8,
      }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

