"======= WHICH ENV ============================================================"
" Establish which environment vim/neovim is running in.
if !exists('g:env')
    if has('win64') || has('win32') || has('win16')
        let g:env = 'WINDOWS'
    else
        let g:env = toupper(substitute(system('uname'), '\n', '', ''))
    endif
endif

"======= LATER USE ============================================================"
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

"======= ENVIRONMENT =========================================================="
if g:env =~ 'WINDOWS'
    behave mswin
    set shell=powershell.exe
    set shellcmdflag=\ -NoLogo\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellquote= shellpipe=\| shellxquote=
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
    let g:python_host_prog = 'C:\Users\lsymington\scoop\shims\python2.EXE'
    let g:python3_host_prog = 'C:\Users\lsymington\scoop\shims\python3.EXE'
elseif g:env =~ 'DARWIN'
    set shell=/usr/local/bin/fish
elseif g:env =~ 'LINUX'
    set shell=fish
endif
