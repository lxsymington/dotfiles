"======================================================================================================================"
"======= NEOVIM COMPATIBILITY ========================================================================================="
"======================================================================================================================"
if has('nvim')
    if g:env =~ 'WINDOWS'
        set shell=cmd.exe
        " set shell=powershell.exe shellquote=\" shellpipe=\| shellredir=>
        " set shellcmdflag=\ -NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
        " let &shellxquote=' '
    endif
    if g:env =~ 'DARWIN'
    	set shell=/usr/local/bin/fish
    endif
    tnoremap <Leader><Esc> <C-\><C-n>
else
    set ttymouse=xterm2
endif
