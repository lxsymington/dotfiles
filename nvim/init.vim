"======================================================================================================================"
"======== General ====================================================================================================="
"======================================================================================================================"
"Used the latest options/settings (If available)
if &compatible
 set nocompatible
endif

"Sources the plugins file
so ~/.config/nvim/plugins.vim

"Use 256 Colors. This is useful for terminal Vim
set termguicolors

"Sets encoding to UTF-8
set encoding=utf-8

"Enables syntax highlighting
syntax enable

"Security
set modelines=0

"Sets the backspace behaviour to conventional
set backspace=indent,eol,start

"Change the default leader ('/') character for custom mappings
let mapleader = ','

"Enables line numbers
set relativenumber

"Sets GUI Vim line height
set linespace=2

"Force the cursor onto a new line after 120 characters
set textwidth=120

"Creates a visual boundary
set colorcolumn=+1

"Displays invisibles
set list

"Sets characters to display for invisible characters
set listchars=space:⋅,tab:⇥\ ,eol:¬

"Always show status line
set laststatus=2

"Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

"Enable the mouse
set mouse=a

"======================================================================================================================"
"======= TAB-SETTINGS ================================================================================================="
"======================================================================================================================"
"Visual spaces per tab
set tabstop=4

"Size of a <TAB> character
set shiftwidth=4

"Number of spaces per tab
set softtabstop=4

"Use multiples of shiftwidth when indenting with '<' and '>'
set shiftround

"Insert spaces when pressing tab
set expandtab

"Insert tabs on the start of a lin according to shiftwidth not tabstop
set smarttab

"======================================================================================================================"
"======= UI ==========================================================================================================="
"======================================================================================================================"
"Keeps X lines visible when scrolling
set scrolloff=5

"auto indent when editing
set autoindent

"copy the previous indentation on autoindenting
set copyindent

" ? Fixes bad indenting
set cindent

" ? Fixes bad indenting
set smartindent

"Highlight matching parens
set showmatch

"Show command in bottom bar
set showcmd

"Visual autocomplete of command menu
set wildmenu

"Highlights the current line
set cursorline

"Redraws only when needed
set lazyredraw

"Performance
set ttyfast

"Keep 50 lines of command line history
set history=50

"======================================================================================================================"
"======= VISUALS ======================================================================================================"
"======================================================================================================================"
"Enable the Palenight variation of the Material theme
let g:material_style='palenight'

"Sets the background to be dark
set background=dark

"Sets the theme to be the Material theme
colorscheme vim-material

"======================================================================================================================"
"======= SEARCH ======================================================================================================="
"======================================================================================================================"
"Enables the highlighting of search results
set hlsearch

"Show search matches as you type
set incsearch

"======================================================================================================================"
"======= SPLIT-MANAGEMENT ============================================================================================="
"======================================================================================================================"
"When a new horizontal split is opened it is opened below
set splitbelow

"When a new vertical split is opened it is opened to the right
set splitright

"Maps ^J to changing to the split below
nmap <C-J> <C-W><C-J>

"Maps ^K to changing to the split above
nmap <C-K> <C-W><C-K>

"Maps ^H to changing to the split to the left
nmap <C-H> <C-W><C-H>

"Maps ^L to changing to the split to the right
nmap <C-L> <C-W><C-L>

"======================================================================================================================"
"======= MAPPINGS ====================================================================================================="
"======================================================================================================================"
"A shortcut for opening the ~/.vimrc in a new tab.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"A shortcut for removing the search highlighting.
nmap <Leader><space> :nohlsearch<cr>

"======================================================================================================================"
"======= PLUGINS ======================================================================================================"
"======================================================================================================================"

"~~~~~~~ NERDTree ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Prevent NERDTree from hijacking vinegar
let NERDTreeHijackNetrw = 0

"A shortcut for NERDTree
nmap <Leader><Tab> :NERDTreeToggle<cr>

"~~~~~~~ Ale ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Integrates Ale with vim-ariline
let g:airline#extensions#ale#enabled = 1

" Configures Ale file linters
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sass': ['stylelint'],
\}

" Configures Ale file fixers
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sass': ['stylelint'],
\}

" Set Ale to fix files automatically on save.
let g:ale_fix_on_save = 1

" Shows a list of errors when they exist in the file.
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

"~~~~~~~ Deoplete ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Enables Deoplete at nvim startup
let g:deoplete#enable_at_startup = 1

"~~~~~~~ Vim-airline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Tells airline to use the Material theme
let g:airline_theme='material'

"======================================================================================================================"
"======= FUNCTIONS ===================================================================================================="
"======================================================================================================================"
"Check if relativenumber is set, if not set it
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

"Map leader leader to toggle line numbers
nnoremap <leader><leader> :call NumberToggle()<cr>
