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
    return winwidth(0) > 70 && strlen(l:filePath) < 40 ? l:filePath : pathshorten(l:filePath)
endfunction


function! StatuslineGit()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? '  '.l:branchname.' ':''
endfunction

function! FileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . nerdfont#find() . ' ' : 'no ft') : ''
endfunction

function! FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! FileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . nerdfont#fileformat#find()) . ' ' : ''
endfunction

"Coc utility function
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

function! CreatePill(colour, ...)
      let l:start ='%#' . a:colour . '#%#' . a:colour . 'BG#'
      let l:end = '%#' . a:colour . '#'
      let l:content = join(a:000, '')
      return strlen(l:content) . 0 ? l:start . l:content . l:end : ''
endfunction

function! StatusLineString()
    let l:statusleft = [CreatePill('Grey', CurrentMode()), CreatePill('LightGreen', '%<', FilePath(), '%m', '%r', ' ', '%#PurpleBG#', StatuslineGit())]
    let l:statuscentre = [CreatePill('Red','%n'), CreatePill('LightBlack', FileType()), CreatePill('Purple', coc#status())]
    let l:statusright = [CreatePill('LightBlack', FileEncoding()), CreatePill('Grey', FileFormat()), CreatePill('LightGrey', '%l:%c'), CreatePill('White', '%p%%')]
    let l:statusline = [join(l:statusleft), join(l:statuscentre), join(l:statusright)]
    return join(l:statusline, '%=')
endfunction

"Always show status line
set laststatus=2

"Initialise the statusline
set statusline=%!StatusLineString()
