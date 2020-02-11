"~~~~~~~ Ale ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
" Configures Ale file linters
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['tsserver', 'tslint', 'eslint', 'prettier'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sass': ['stylelint'],
\   'rust': ['cargo', 'rls', 'rustfmt'],
\ }

" Configures Ale file fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'tslint', 'eslint'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sass': ['stylelint'],
\   'rust': ['rustfmt'],
\ }

" Set Ale to fix files automatically on save.
let g:ale_fix_on_save = 1

" Set Ale to show virtual text when the cursor is over a problem
let g:ale_virtualtext_cursor = 1

" Set Ale to show balloons with details about the problem
let g:ale_set_balloons = 1

" Set Ale not to set highlight styles
let g:ale_set_highlights = 1

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

" Enable completion
let g:ale_completion_enabled = 0
let g:ale_completion_delay = 100

" Set ALE error sign
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '!'

" Set ALE to enable autoimports for TypeScript files.
let g:ale_completion_tsserver_autoimport = 1

set completeopt=menu,menuone,preview,noselect,noinsert
set omnifunc=ale#completion#OmniFunc
