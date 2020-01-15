"======================================================================================================================"
"======= WHICH ENV ===================================================================================================="
"======================================================================================================================"
" Establish which environment vim/neovim is running in.
if !exists('g:env')
    if has('win64') || has('win32') || has('win16')
        let g:env = 'WINDOWS'
    else
        let g:env = toupper(substitute(system('uname'), '\n', '', ''))
    endif
endif

"~~~~~~~ LATER USE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Example usage
" if g:env =~ 'WINDOWS'
    " Enable Windows specific settings/plugins
" endif

" if g:env =~ 'LINUX'
    " Enable Linux specific settings/plugins
" endif

" if g:env =~ 'DARWIN'
    " Enable MacOS specific settings/plugins
" endif
"
" if g:env =~ 'MINGW'
    " Enable MinGW specific settings/plugins (Git Bash, mainly)
" endif

"======================================================================================================================"
"======= ENVIRONMENT =================================================================================================="
"======================================================================================================================"
if has('nvim')
    if g:env =~ 'WINDOWS'
        " set shell=cmd.exe
        set shell=pwsh.exe
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
