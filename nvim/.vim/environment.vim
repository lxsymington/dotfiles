"======================================================================================================================"
"======= ENVIRONMENT =================================================================================================="
"======================================================================================================================"
if has('nvim')
    if g:env =~ 'WINDOWS'
        " set shell=cmd.exe
        set shell=pwsh
        set shellcmdflag=-c
    elseif g:env =~ 'DARWIN'
        set shell=/usr/local/bin/fish
    elseif g:env =~ 'LINUX'
        set shell=/usr/local/bin/fish
    endif
    tnoremap <Leader><Esc> <C-\><C-n>
else
    set ttymouse=xterm2
endif
