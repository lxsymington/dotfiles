"======================================================================================================================"
"======= NEOVIM COMPATIBILITY ========================================================================================="
"======================================================================================================================"
if has('nvim')
    if (WhichEnv() =~# 'WINDOWS') 
        set shell=pwsh.exe
    else
        set shell=/usr/local/bin/fish
    endif
    tnoremap <Leader><Esc> <C-\><C-n>
else
    set ttymouse=xterm2
endif
