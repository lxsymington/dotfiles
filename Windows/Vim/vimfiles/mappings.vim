"======================================================================================================================"
"======= MAPPINGS ====================================================================================================="
"======================================================================================================================"
"A shortcut for opening the ~/.vimrc in a new tab.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"A shortcut for removing the search highlighting.
nmap <Leader><space> :nohlsearch<cr>

"A shortcut for toggling NERDTree
map <Leader><tab> :NERDTreeToggle<CR>

"Allow escape to function as expected even in terminal windows
tnoremap <Esc> <C-\><C-n>
