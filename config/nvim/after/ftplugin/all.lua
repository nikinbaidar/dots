
vim.cmd [[
function! CopyMatches(reg, start, end) range
    " Copies all matched patterns of the most recent search.
    " a,bCopyMatches copies matched patterns from lines a to b.
    let hits = []
    let reg = empty(a:reg) ? '+' : a:reg
    let range = (a:start == a:end) ? '%' : a:start.','.a:end 
    execute range.'s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne'
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

command! -nargs=* -range -register CopyMatches call CopyMatches(<q-reg>, <line1>, <line2>)
]]
