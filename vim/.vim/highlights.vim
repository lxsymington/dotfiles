"======================================================================================================================"
"======= HIGHLIGHTS ==================================================================================================="
"======================================================================================================================"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
"Configure ALE highlights
hi ALEWarning guibg=NONE guisp=yellow gui=undercurl,bold ctermfg=yellow ctermbg=NONE cterm=undercurl,bold term=undercurl,bold
hi ALEError guibg=NONE guisp=red gui=undercurl,bold ctermfg=red ctermbg=NONE cterm=undercurl,bold term=undercurl,bold

" hi User1 cterm=bold,reverse ctermfg=Green ctermbg=None gui=bold,reverse guifg=Green guibg=None
" hi User2 cterm=bold,reverse ctermfg=Blue ctermbg=Yellow gui=bold,reverse guifg=Blue guibg=Yellow

" exe "hi! User1" .' ctermfg=".g:terminal_color_0."'" .' guifg=".g:terminal_color_0."'"
