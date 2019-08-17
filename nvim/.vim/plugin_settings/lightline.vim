"~~~~~~~ Lightine Vim ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Lightine settings
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['gitbranch', 'readonly', 'filename', 'modified'],
    \       ['ctrlpmark', 'git', 'diagnostic', 'cocstatus']
    \   ],
    \   'right': [
    \       ['filetype', 'fileencoding', 'lineinfo', 'percent'],
    \       ['blame']
    \   ]
    \ },
    \ 'component_function': {
    \   'blame': 'LightlineGitBlame',
    \   'gitbranch': 'fugitive#head'
    \ }
\ }

function!LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    return winwidth(0) > 120 ? blame : ''
endfunction
