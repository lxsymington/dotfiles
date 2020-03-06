"~~~~~~~ Lightine Vim ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Dev Icons utility function
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

"Dev Icons utility function
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"Coc utility function
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

"Lightine settings
let g:lightline = {
    \ 'colorscheme': 'nightowl',
    \ 'active': {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['gitbranch', 'readonly', 'relativepath', 'modified'],
    \       ['git', 'diagnostic']
    \   ],
    \   'right': [
    \       ['lineinfo', 'percent'],
    \       ['fileencoding', 'fileformat'],
    \       ['filetype'],
    \       ['cocstatus', 'currentfunction']
    \   ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \ }
\ }
