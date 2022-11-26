setlocal bufhidden=delete
setlocal colorcolumn=
let g:netrw_dirhistmax  = 0 " Don't save netrw history or bookmarks
let g:netrw_bufsettings = 'number nowrap noma nomod nobl ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,.*\.class$'
