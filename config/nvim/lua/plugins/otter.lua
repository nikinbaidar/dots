local otter = require("otter")
otter.setup({
  lsp = {
    diagnostic_update_events = { "BufWritePost" },

    root_dir = function(_, bufnr)
      return vim.fs.root(bufnr or 0, {
        ".git",
        "_quarto.yml",
        "package.json",
      }) or vim.fn.getcwd(0)
    end,
  },

  buffers = {
    set_filetype = true,
    write_to_disk = false,
    preambles = {},
    postambles = {},
    ignore_pattern = {
      -- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
      python = "^(%s*[%%!].*)",
    },
  },
  handle_leading_whitespace = true,
  extensions = {},
  debug = false,
  verbose = { 
    no_code_found = false, 
  },
})
