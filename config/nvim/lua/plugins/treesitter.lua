-- NOTE: Nvim 0.12 ships a built-in tree-sitter support along with built-in
-- parsers for common languages, so tree-sitter works without any plugin at all.
-- However, the core only bundles a handful of parses. However,
-- `nvim-treesitter/nvim-treesitter` is still installed only so I can load
-- parsers for other programming languages like Python, JS, Bash, Rust etc, that
-- have no built-in support in 0.12 (which might change in the future)


-- TODO: Keep checking `/usr/share/nvim/runtime/parser` to see if additional
-- parsers are supported.


local ts = require('nvim-treesitter')

ts.install({ 'python', 'javascript', 'bash', 'java', })
