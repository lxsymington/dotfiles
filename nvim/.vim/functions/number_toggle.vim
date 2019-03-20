"======================================================================================================================"
"======= FUNCTIONS ===================================================================================================="
"======================================================================================================================"
"Check if relativenumber is set, if not set it
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

"Map leader leader to toggle line numbers
nnoremap <leader><leader> :call NumberToggle()<cr>

