"======================================================================================================================"
"======= MAPPINGS ====================================================================================================="
"======================================================================================================================"
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

"A shortcut for opening a Vista tag sidebar
nmap <Leader>vt :Vista!!<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>ff :Files<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>fgf :GFiles<cr>

"A shortcut for opening a fuzzy find file window.
nmap <Leader>fgs :GFiles?<cr>

"A shortcut for opening a file explorer
nmap <Leader><Tab> :Fern . -drawer -reveal=% -width=30 -toggle<cr>

"A shortcut for exploring the current folder
nmap <Leader><Leader> :Fern %:h -reveal=%<cr>

"A shortcut for toggling Goyo
nmap <Leader>G :Goyo<cr>

"Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"Goto shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)

"Rename shortcut
nmap <leader>rn <Plug>(coc-rename)

"Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"Applying codeAction to the selected region.
"Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)

"Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
