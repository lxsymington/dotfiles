"~~~~~~~ Ale ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Integrates Ale with vim-ariline
let g:airline#extensions#ale#enabled = 1

" Configures Ale file linters
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sass': ['stylelint'],
\   'rust': ['cargo', 'rls', 'rustfmt'],
\}

" Configures Ale file fixers
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sass': ['stylelint'],
\   'rust': ['rustfmt'],
\}

" Set Ale to fix files automatically on save.
let g:ale_fix_on_save = 1

" Set Ale to show virtual text when the cursor is over a problem
let g:ale_virtualtext_cursor = 1

" Set Ale to show balloons with details about the problem
let g:ale_set_balloons = 1

" Set Ale not to set highlight styles
let g:ale_set_highlights = 1

" Shows a list of errors when they exist in the file (if set to `1`).
let g:ale_open_list = 0

" Sets Ale to use the loclist instead of the quickfix list
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

" Enable completion
let g:ale_completion_enabled = 0
let g:ale_completion_delay = 100

" Set ALE error sign
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '!'

set completeopt=menu,menuone,preview,noselect,noinsert
