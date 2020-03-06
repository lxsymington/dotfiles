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
set ambiwidth=single

"Always show status line
set laststatus=2

"Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

"Enable the mouse
set mouse=a

"Set the chord timeout length to 500ms
set timeoutlen=1000 ttimeoutlen=100

"Set wrapped lines to continue visual indentation
set breakindent

"Set breakindent options
set breakindentopt=min:20,shift:0,sbr

"Preview effects of :%s as you type
set inccommand=nosplit

"Hide abandoned buffers instead of unloading them
set hidden

"Enable auto-saving
set autowriteall

"Enable auto-reading
set autoread

"Look into using an auto-command and `FocusLost` to auto save when leaving nvim

"Do not keep a backup file, use versions instead
set nobackup
set nowritebackup

"Extra line for display command messages
set cmdheight=1

"Set a shorter time before the CursorHold event is triggered
set updatetime=300

"Don't show |ins-completion-menu| messages
set shortmess+=c

"Keep an undo file (undo changes after closing)
if has('persistent_undo')
    set undofile
endif
