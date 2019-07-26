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

"Sets the colorscheme to be Seoul 256
colorscheme seoul256

"Sets the background to be dark
set background=dark
let g:seoul256_background = 235
