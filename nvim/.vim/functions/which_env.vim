"======================================================================================================================"
"======= WHICH ENV ===================================================================================================="
"======================================================================================================================"
" Establish which environment vim/neovim is running in.
function! WhichEnv() abort
	if has('win64') || has('win32') || has('win16')
		return 'WINDOWS'
	else
		return toupper(substitute(system('uname'), '\n', '', ''))
	endif
endfunction

"~~~~~~~ LATER USE IN ANOTHER FILE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Example usage
" if (WhichEnv() =~# 'WINDOWS')
"     " Enable Windows specific settings/plugins
" else if (WhichEnv() =~# 'LINUX')
"     " Enable Linux specific settings/plugins
" else if (WhichEnv() =~# 'DARWIN')
"     " Enable MacOS specific settings/plugins
" else
"     " Other cases I can't think of like MINGW
" endif
