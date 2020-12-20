"======= MAPPINGS ============================================================="
"A shortcut for the escape key.
imap jj <esc>

"Maps ^J to changing to the split below
nmap <C-J> <C-W><C-J>

"Maps ^K to changing to the split above
nmap <C-K> <C-W><C-K>

"Maps ^H to changing to the split to the left
nmap <C-H> <C-W><C-H>

"Maps ^L to changing to the split to the right
nmap <C-L> <C-W><C-L>

"A shortcut for opening the ~/.vimrc in a new tab.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"A shortcut for removing the search highlighting.
nmap <Leader><space> :nohlsearch<cr>

"Map leader leader to toggle line numbers
nnoremap <leader># :call NumberToggle()<cr>
