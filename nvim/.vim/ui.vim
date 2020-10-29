"======================================================================================================================"
"======= UI ==========================================================================================================="
"======================================================================================================================"
"Keeps X lines visible when scrolling
set scrolloff=5

"auto indent when editing
set autoindent

"copy the previous indentation on autoindenting
set copyindent

"Syntax aware indent correction
set cindent
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

"Always show the sign column
set signcolumn=yes

"Make splits remain equal
set equalalways

"Display the foldcolumn
set foldcolumn=1

"Enable pseudo-transparency for popup menus
if has('nvim')
    set pumblend=10
endif

"Enable pseudo-transparency for floating windows
if has('nvim')
    set winblend=10
endif

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
