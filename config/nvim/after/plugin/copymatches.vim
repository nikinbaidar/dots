
" ░█▀▀░█▀█░█▀█░█░█░█▄█░█▀█░▀█▀░█▀▀░█░█░█▀▀░█▀▀░░░░█░█░▀█▀░█▄█
" ░█░░░█░█░█▀▀░░█░░█░█░█▀█░░█░░█░░░█▀█░█▀▀░▀▀█░░░░▀▄▀░░█░░█░█
" ░▀▀▀░▀▀▀░▀░░░░▀░░▀░▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░░▀▀▀░▀░▀

" Copies all the patterns that matches a search command. Useful to get a quick peek at what patterns are present that match a regexp in a file instead of pressing 'n' many times. Works wonders for machine learning projects when you're running EDA.


function! CopyMatches(reg, start, end) range
    let hits = []
    let reg = empty(a:reg) ? '+' : a:reg
    let range = (a:start == a:end) ? '%' : a:start.','.a:end 
    execute range.'s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne'
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

command! -nargs=* -range -register CopyMatches call CopyMatches(<q-reg>, <line1>, <line2>)

