"======================================================================================================================"
"======= MAPPINGS ====================================================================================================="
"======================================================================================================================"
"A shortcut for opening the ~/.vimrc in a new tab.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"A shortcut for removing the search highlighting.
nmap <Leader><space> :nohlsearch<cr>

"Map leader leader to toggle line numbers
nnoremap <leader># :call NumberToggle()<cr>

"A shortcut for opening a Vista tag sidebar
nmap <Leader>vt :Vista!!<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>ff :Files<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>fgf :GFiles<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>fgs :GFiles?<cr>

"A shortcut for opening a file explorer
nmap <Leader><Tab> :Defx -toggle -split=vertical -winwidth=50 -direction=topleft<cr>

"A shortcut for exploring the current folder
nmap <Leader><Leader> :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>

"A shortcut for toggling Goyo
nmap <Leader>g :Goyo<cr>
