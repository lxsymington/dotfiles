"======================================================================================================================"
"======= THEME ========================================================================================================"
"======================================================================================================================"
"Set terminal to use true color
if (has("termguicolors"))
    set termguicolors

    "Set Vim-specific sequences for RGB colors
    set t_8b=[48;2;%lu;%lu;%lum
    set t_8f=[38;2;%lu;%lu;%lum
elseif
    set t_Co=256

    set t_AB=[48;5;%dm
    set t_AF=[38;5;%dm
endif

"Sets the theme to be the Material theme
" colorscheme vim-material
"Sets the theme to be the One theme
" colorscheme one
"Sets the theme to be the Seoul 256 theme
colorscheme seoul256

"Enable Italics for the Vim One theme
" let g:one_allow_italics = 1

"Sets the background to be dark
set background=dark

"Alter the background colour for Seoul 256
let g:seoul256_background = 235
