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

"Sets the background to be dark
set background=dark

"Sets the theme to be the Material theme
colorscheme one
" colorscheme vim-material

"Enable Italics for the Vim One theme
let g:one_allow_italics = 1

"Enable the Palenight variation of the Material theme
" let g:material_style='palenight'

