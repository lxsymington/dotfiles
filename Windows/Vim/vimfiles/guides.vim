"======================================================================================================================"
"======= GUIDES ======================================================================================================="
"======================================================================================================================"
" Colour the 81st column
set colorcolumn+=81

"Force the cursor onto a new line after 120 characters
set textwidth=120

" However, in Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72

" Colour the 121st (or 73rd) column so that we don’t type over our limit
set colorcolumn=+1

" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51
