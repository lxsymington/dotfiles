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
  return winwidth(0) > 70 ? (strlen(&filetype) ? ' ' . &filetype . ' ' . nerdfont#find() . ' ' : 'no ft') : ''
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
set statusline+=%#GreyBG#
set statusline+=%{CurrentMode()}
set statusline+=%#Grey#
set statusline+=\ 
set statusline+=%#LightGreen#
set statusline+=
set statusline+=%#LightGreenBG#
set statusline+=%{FilePath()}
set statusline+=%m
set statusline+=%r
set statusline+=%#LightGreen#
set statusline+=\ 
set statusline+=%#LightBlack#
set statusline+=
set statusline+=%#LightBlackBG#
set statusline+=\ 
set statusline+=%{StatuslineGit()}
set statusline+=%#LightBlack#
set statusline+= 
set statusline+=%=
set statusline+=%#Red#
set statusline+=
set statusline+=%#RedBG#
set statusline+=%n
set statusline+=%#Red#
set statusline+=\ 
set statusline+=%#LightBlack#
set statusline+=
set statusline+=%#LightBlackBG#
set statusline+=%{Filetype()}
set statusline+=%#LightBlack#
set statusline+=\ 
set statusline+=%#Purple#
set statusline+=
set statusline+=%#PurpleBG#
set statusline+=%{coc#status()}
set statusline+=%#Purple#
set statusline+=
set statusline+=%=
set statusline+=%#LightBlack#
set statusline+=
set statusline+=%#LightBlackBG#
set statusline+=%{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \|\ 
set statusline+=%{Fileformat()}
set statusline+=\ \|\ 
set statusline+=%l:%c
set statusline+=\ \|\ 
set statusline+=%p%%
set statusline+=%#LightBlack#
set statusline+=
