"======= FZF =================================================================="
"<C-a> <C-q> to select all results and build a quickfix list
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

function! s:RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

"Use a centered popup window
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.85 } }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

let $FZF_DEFAULT_COMMAND="fd --type=file --color=always --follow --hidden --exclude=.git"
let $FZF_DEFAULT_OPTS="--ansi --preview-window='right:50%' --preview 'bat --color=always --style=full --line-range=:300 {}'"

command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

command! -nargs=* -bang RG call s:RipgrepFzf(<q-args>, <bang>0)

"======= Mappings ============================================================="
"Fuzzy find project files
nnoremap <Leader>ff :Files<cr>

"Fuzzy find project git files
nnoremap <Leader>fgf :GFiles<cr>

"Fuzzy find project changed git files
nnoremap <Leader>fgs :GFiles?<cr>

"Live grep of the project
nnoremap <Leader>lg :RG<cr>
