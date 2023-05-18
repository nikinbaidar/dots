" nnoremap <leader>v :call ViewPDF()<CR>

function! ViewPDF()
    let g:headmost = getline(1)
    let g:documentclass = execute("g/documentclass/z#.1")
    if (g:documentclass !~ "Pattern not found: documentclass")
      let g:pdffile = expand("%:r").".pdf"
    elseif (g:headmost[0] =~ "%")
      let g:headmost_length = strlen(g:headmost) - 5
      let g:source_path = g:headmost[2:g:headmost_length]
      let g:pdffile = expand(g:source_path).".pdf"
      if empty(expand(glob("./" . g:pdffile)))
          let g:pdffile = "../".g:pdffile
      endif
    endif
    execute ("silent ! jumanji") g:pdffile
endfunction

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
      execute ("term xelatex --shell-escape") g:source_path
    elseif ! empty(expand(glob("../" .g:source_path)))
      " Source in previous directory
      below split
      resize 15
      cd .. | execute ("term xelatex --shell-escape") g:source_path | cd -
    endif
  endif
endfunction

function! RunLatex()
    update!
    if expand('%:e') =~ "dn"
      call AddDevanagari()
    else
      normal! mh
      let g:documentclass = execute("g/documentclass/z#.1")
      normal! `hzz
      if g:documentclass =~ "Pattern not found: documentclass"
        " Current file is not a source file.
        call CompileSource()
      else
        " Current file is a source file.
        below split
        resize 15
        term xelatex --shell-escape %
      endif
    endif
endfunction

function! AddDevanagari()
  let g:texfile = expand("%:r").".tex"
  execute("silent term devnag % | xelatex ") g:texfile
endfunction
