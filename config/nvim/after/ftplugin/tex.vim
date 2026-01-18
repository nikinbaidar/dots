function! BiblatexCompile()
    :! clear ; biber %:r
    silent call RunLatex()
endfunction


function! CompileSource()

    let g:headmost = getline(1)
    if g:headmost[0] =~ "%"
        let g:source_path = getline(1)[2:]
        if ! empty(expand(glob("./" . g:source_path)))
            " Source in current directory
            below split
            resize 15
            execute ("term lualatex --shell-escape") g:source_path
        elseif ! empty(expand(glob("../" .g:source_path)))
            " Source in previous directory
            below split
            resize 15
            cd .. | execute ("term lualatex --shell-escape") g:source_path | cd -
        endif
    endif
endfunction

function! RunLatex()
    normal! mh
    silent! execute '%s/\v(^|\s)(|[{[(]|)"/\1\2``/g'
    silent! execute '%s/\v(^|\s)(|[{[(]})''/\1\2`/g'
    silent! execute 'g/% Press <C-l> to add \w\+/d'
    silent! execute '%s/\s\+$//e'
    silent! execute '%s/\n\{3,}/\r\r/e'
    update!
    if expand('%:e') =~ "dn"
        call AddDevanagari()
    else
        let g:documentclass = execute("g/documentclass/z#.1")
        normal! `hzz
        if g:documentclass =~ "Pattern not found: documentclass"
            " Current file is not a source file.
            call CompileSource()
        else
            " Current file is a source file.
            below split
            resize 15
            term lualatex --shell-escape %
        endif
    endif

endfunction

function! AddDevanagari()
    let g:texfile = expand("%:r").".tex"
    execute("silent term devnag % | lualatex ") g:texfile
endfunction

