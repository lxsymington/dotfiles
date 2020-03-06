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

"Sets the colorscheme to be Seoul 256
colorscheme seoul256-light
colorscheme seoul256
colorscheme night-owl

"Sets the background to be dark
set background=dark
