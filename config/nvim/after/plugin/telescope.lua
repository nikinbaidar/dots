local telescope = require('telescope')

telescope.setup {
  defaults = {
      layout_config = {
          width=0.95;
      },
      results_title = "Matches",
  },
  pickers = {
      find_files = {
          cwd = "~/",
          file_ignore_patterns = {".git", "node_modules"},
      },
  },
  extensions = {
      fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

