"Vim currentMode
function! CurrentMode()
  "See :h mode()
  let l:currentMode = {
        \ 'n': 'NORMAL',
        \ 'no': 'OPERATOR-PENDING',
        \ 'nov': 'OPERATOR-PENDING',
        \ 'noV': 'OPERATOR-PENDING',
        \ 'noCTRL-V': 'OPERATOR-PENDING',
        \ 'no': 'OPERATOR-PENDING',
        \ 'niI': 'N-INSERT',
        \ 'niR': 'N-REPLACE',
        \ 'niV': 'N-V-REPLACE',
        \ 'v': 'VISUAL',
        \ 'V': 'V-LINE',
        \ 'CTRL-V': 'V-BLOCK',
        \ '': 'V-BLOCK',
        \ 's': 'SELECT',
        \ 'S': 'S-LINE',
        \ 'CTRL-S': 'S-BLOCK',
        \ '': 'S-BLOCK',
        \ 'i': 'INSERT',
        \ 'ic': 'I-COMPLETE',
        \ 'ix': 'I-COMPLETE',
        \ 'R': 'REPLACE',
        \ 'Rc': 'R-COMPLETE',
        \ 'Rv': 'R-V-COMPLETE',
        \ 'Rx': 'R-COMPLETE',
        \ 'c': 'COMMAND',
        \ 'cv': 'EX-MODE',
        \ 'ce': 'EX-MODE',
        \ 'r': 'HIT-ENTER',
        \ 'rm': 'MORE',
        \ 'r?': 'CONFIRM',
        \ '!': 'SHELL',
        \ 't': 'TERMINAL',
        \}

  return toupper(l:currentMode[mode()])
endfunction

function! FilePath()
    "See :h filename-modifiers
    let l:filePath = fnamemodify(expand('%:p'), ':p:~:.')
  return winwidth(0) > 70 ? l:filePath : pathshorten(l:filePath)
endfunction


function! StatuslineGit()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? ' '.l:branchname.' ':''
endfunction

function! Filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . nerdfont#find() : 'no ft') : ''
endfunction

function! Fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . nerdfont#fileformat#find()) : ''
endfunction

"Coc utility function
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction


"Always show status line
set laststatus=2

"Initialise the statusline

set statusline=
set statusline+=%#Grey#
set statusline+=
set statusline+=%1*
set statusline+=%{CurrentMode()}
set statusline+=%#Grey#
set statusline+=\ 
set statusline+=%#Green#
set statusline+=
set statusline+=%1*
set statusline+=%{FilePath()}
set statusline+=%m
set statusline+=%r
set statusline+=%#Green#
set statusline+=\ 
set statusline+=%#Blue#
set statusline+=
set statusline+=%2*
set statusline+=%{StatuslineGit()}
set statusline+=%#Blue#
set statusline+= 
set statusline+=%=
set statusline+=
set statusline+=%n
set statusline+=\ 
set statusline+=
set statusline+=%{coc#status()}
set statusline+=\ 
set statusline+=
set statusline+=%{Filetype()}
set statusline+=
set statusline+=%=
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{Fileformat()}\]
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ 
