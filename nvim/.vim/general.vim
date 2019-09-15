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
"======== GENERAL ====================================================================================================="
"======================================================================================================================"
"Used the latest options/settings (If available)
if &compatible
    set nocompatible
endif

"Sets encoding to UTF-8
set encoding=utf-8

"Do not add BOM marks
set nobomb

"Use host system format
set fileformats=unix,dos,mac

"Enables syntax highlighting
syntax enable

"Security
set modelines=0

"Sets the backspace behaviour to conventional
set backspace=indent,eol,start

"Change the default leader ('/') character for custom mappings
let mapleader = ','

"Enables line numbers
set number relativenumber

"Force the cursor onto a new line after 120 characters
set textwidth=120

"Creates a visual boundary
set colorcolumn=81,+1

"Displays invisibles
set list

"Sets characters to display for invisible characters
set listchars=space:.,tab:~\ ,eol:¬

"Sets ambiguous width characters to be double width
set ambw=double

"Always show status line
set laststatus=2

"Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

"Enable the mouse
set mouse=a

"Set the chord timeout length to 500ms
set timeoutlen=1000 ttimeoutlen=100

"Set wrapped lines to continue visual indentation
set bri

"Set breakindent options
set briopt=min:20,shift:0,sbr

"Enable auto-saving
set awa

"Look into using an auto-command and `FocusLost` to auto save when leaving nvim

"Do not keep a backup file, use versions instead
set nobackup

"Keep an undo file (undo changes after closing)
if has('persistent_undo')
    set undofile
endif
