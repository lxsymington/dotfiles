"~~~~~~~ Lightine Vim ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Lightine settings
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method']
    \   ],
    \   'right': [
    \       ['filetype', 'fileencoding', 'lineinfo', 'percent'],
    \       ['blame']
    \   ]
    \ },
    \ 'component_function': {
    \   'blame': 'LightineGitBlame',
    \ }
\ }

function!LightineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    return winwidth(0) > 120 ? blame : ''
endfunction
