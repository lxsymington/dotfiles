"======= CoC =================================================================="
let g:coc_config_home = '~/.coc/'
let g:coc_data_home = '~/.coc/data/'
let g:coc_install_yarn_cmd = 'yarn'

"Show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction.

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"Setup Prettier
command! -nargs=0 Prettier :call CocCommand prettier.formatFile

"======== Mappings ============================================================"
"Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"Goto shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)

"Rename shortcut
nmap <leader>r <Plug>(coc-rename)

"Use `[g` and `]g` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

"Applying codeAction to the selected region.
"Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"Remap keys for applying codeAction to the current line.
nmap <leader>ca  <Plug>(coc-codeaction)

"Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
