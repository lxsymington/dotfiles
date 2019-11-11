"======================================================================================================================"
"======= MAPPINGS ====================================================================================================="
"======================================================================================================================"
"A shortcut for opening the ~/.vimrc in a new tab.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"A shortcut for removing the search highlighting.
nmap <Leader><space> :nohlsearch<cr>

"Map leader leader to toggle line numbers
nnoremap <leader># :call NumberToggle()<cr>

"A shortcut for opening a Vista tag sidebar
nmap <Leader>vt :Vista!!<cr>

"A shortcut for viewing the ALEDetail
nmap <Leader>d :ALEDetail<cr>

"A shortcut for using ALE to go to the definition
nmap <Leader>gd :ALEGoToDefinition<cr>

"A shortcut for using ALE to go to the type definition
nmap <Leader>gtd :ALEGoToTypeDefinition<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>ff :Files<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>fgf :GFiles<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>fgs :GFiles?<cr>

"A shortcut for opening a file explorer
nmap <Leader><Tab> :Defx -toggle -split=vertical -winwidth=50 -direction=topleft<cr>

"A shortcut for exploring the current folder
nmap <Leader><Leader> :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>

"A shortcut for toggling Goyo
nmap <Leader>G :Goyo<cr>

"CoC Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"CoC Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"CoC use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"CoC Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"CoC Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"CoC Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"CoC Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

"CoC Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)
