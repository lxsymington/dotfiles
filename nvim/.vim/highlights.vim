"======================================================================================================================"
"======= HIGHLIGHTS ==================================================================================================="
"======================================================================================================================"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
"Configure ALE highlights
hi ALEWarning guibg=none guisp=yellow gui=undercurl,bold ctermfg=yellow ctermbg=none cterm=undercurl,bold term=undercurl,bold
hi ALEError guibg=none guisp=red gui=undercurl,bold ctermfg=red ctermbg=none cterm=undercurl,bold term=undercurl,bold

"Map F12 to echo the syntax highlight group under the cursor
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" hi User1 cterm=bold,reverse ctermfg=Green ctermbg=None gui=bold,reverse guifg=Green guibg=None
" hi User2 cterm=bold,reverse ctermfg=Blue ctermbg=Yellow gui=bold,reverse guifg=Blue guibg=Yellow

" exe "hi! User1" .' ctermfg=".g:terminal_color_0."'" .' guifg=".g:terminal_color_0."'"
