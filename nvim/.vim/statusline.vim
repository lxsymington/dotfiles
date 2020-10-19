function! StatuslineGit()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? '  '.l:branchname.' ':''
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
set statusline+=
set statusline+=%{mode()}
set statusline+=
set statusline+=%#PmenuSel#
set statusline+=%F%m%r
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=%{Filetype()}
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{Fileformat()}\]
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ 
