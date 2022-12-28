local cmp = require'cmp'

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = ({
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-b>'] = cmp.mapping.scroll_docs(-5),
        ['<C-f>'] = cmp.mapping.scroll_docs(5),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        {name = 'luasnip'}
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
    },
})
