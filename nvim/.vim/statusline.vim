"Vim currentMode
function! CurrentMode()
  "See :h mode()
  let l:modes = {
        \ 'n': ['Normal', 'Green'],
        \ 'no': ['Operator-Pending', 'LightGrey'],
        \ 'nov': ['Operator-Pending', 'LightGrey'],
        \ 'noV': ['Operator-Pending', 'LightGrey'],
        \ 'noCTRL-V': ['Operator-Pending', 'LightGrey'],
        \ 'no': ['Operator-Pending', 'LightGrey'],
        \ 'niI': ['N-Insert', 'LightGreen'],
        \ 'niR': ['N-Replace', 'LightGreen'],
        \ 'niV': ['N-V-Replace', 'LightGreen'],
        \ 'v': ['Visual', 'Blue'],
        \ 'V': ['V-Line', 'LightBlue'],
        \ 'CTRL-V': ['V-Block', 'Cyan'],
        \ '': ['V-Block', 'Cyan'],
        \ 's': ['Select', 'Purple'],
        \ 'S': ['S-Line', 'LightPurple'],
        \ 'CTRL-S': ['S-Block', 'Grey'],
        \ '': ['S-Block', 'White'],
        \ 'i': ['Insert', 'Yellow'],
        \ 'ic': ['I-Complete', 'LightYellow'],
        \ 'ix': ['I-Complete', 'LightYellow'],
        \ 'R': ['Replace', 'Red'],
        \ 'Rc': ['R-Complete', 'LightRed'],
        \ 'Rv': ['R-V-Complete', 'LightRed'],
        \ 'Rx': ['R-Complete', 'LightRed'],
        \ 'c': ['Command', 'LightOrange'],
        \ 'cv': ['EX-Mode', 'Orange'],
        \ 'ce': ['EX-Mode', 'Orange'],
        \ 'r': ['HIT-Enter', 'LightBlack'],
        \ 'rm': ['More', 'LightBlack'],
        \ 'r?': ['Confirm', 'LightBlack'],
        \ '!': ['Shell', 'LightCyan'],
        \ 't': ['Terminal', 'LightCyan'],
        \}

  let l:currentMode = l:modes[mode()]

  return CreatePill([[l:currentMode[1], toupper(l:currentMode[0])]])
endfunction

function! FilePath()
    "See :h filename-modifiers
    let l:filePath = fnamemodify(expand('%:p'), ':p:~:.')
    return winwidth(0) > 70 && strlen(l:filePath) < 40 ? l:filePath : pathshorten(l:filePath)
endfunction


function! StatuslineGit()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? ' '.l:branchname.' ':''
endfunction

function! FileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . nerdfont#find() : 'no ft') . ' ' : ''
endfunction

function! FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! FileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . nerdfont#fileformat#find()) : ''
endfunction

"Coc utility function
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

function! CreatePill(sections)
      if type(a:sections) != v:t_list
            throw 'CreatePill expects a List'
      endif

      let l:start ='%#' . a:sections[0][0] . '#'
      let l:end = '%#' . a:sections[-1][0] . '#'
      let l:content = []

      for [l:colour; l:sectioncontent] in a:sections
            call add(l:content, '%#' . l:colour. 'BG#')
            call add(l:content, join(l:sectioncontent, ''))
      endfor

      return len(l:content) > 0 ? l:start . join(l:content) . l:end : ''
endfunction

function! StatusLineString()
    let l:statusleft = [CurrentMode(), CreatePill([['LightBlack', '%<', FilePath(), '%m', '%r'], ['Blue', StatuslineGit()]])]
    let l:statuscentre = [CreatePill([['Red','%n'], ['LightBlack', FileType()]])] ", ['Purple', coc#status()]
    let l:statusright = [CreatePill([['White', FileEncoding()], ['LightGrey', FileFormat()], ['Grey', '%l:%c'], ['LightBlack', '%p%%']])]
    let l:statusline = [join(l:statusleft), join(l:statuscentre), join(l:statusright)]
    return join(l:statusline, '%=')
endfunction

"Always show status line
set laststatus=2

"Initialise the statusline
set statusline=%!StatusLineString()
