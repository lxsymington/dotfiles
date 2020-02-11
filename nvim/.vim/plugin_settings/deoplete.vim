"~~~~~~~ Deoplete ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"Set Deoplete to be enabled at startup.
let g:deoplete#enable_at_startup = 1

" Use ALE as completion sources for all code.
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})
