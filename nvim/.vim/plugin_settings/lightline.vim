"~~~~~~~ Lightine Vim ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Lightine settings
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['gitbranch', 'readonly', 'relativepath', 'modified'],
    \       ['git', 'diagnostic']
    \   ],
    \   'right': [
    \       ['filetype', 'fileencoding', 'lineinfo', 'percent'],
    \       ['blame']
    \   ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ }
\ }
