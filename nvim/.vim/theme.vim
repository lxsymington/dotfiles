"======================================================================================================================"
"======= THEME ========================================================================================================"
"======================================================================================================================"
"Set terminal to use true color
if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
elseif
    set t_AB="\<Esc>[48;5;%dm"
    set t_AF="\<Esc>[38;5;%dm"
    set t_Co=256
endif

"Sets the colorscheme to be Seoul 256 Light
" colorscheme seoul256-light

"Sets the colorscheme to be Seoul 256
" colorscheme seoul256

"Sets the colorscheme to be Night Owl
colorscheme night-owl

"Miramare configuration
let g:miramare_transparent_background = 1
let g:miramare_enable_italic = 1
let g:miramare_enable_bold = 1

"Sets the colorscheme to be Miramare
colorscheme miramare

"Sets the background to be dark
set background=dark

"Enable background transparency
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
" hi! EndOfBuffer ctermbg=NONE guibg=NONE
" hi! SignColumn ctermbg=NONE guibg=NONE
