"======= Fern ================================================================="
" Disable netrw
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  if !isdirectory(expand('%'))
    return
  endif
  bwipeout %
  Fern %
endfunction

"Use Dev Icons
let g:fern#renderer = "nerdfont"

"======= Mappings ============================================================="
"A shortcut for opening a file explorer
nmap <Leader><Tab> :Fern . -drawer -reveal=% -width=45 -toggle<cr>

"A shortcut for exploring the current folder
nmap <Leader><Leader> :Fern %:h -reveal=%<cr>
