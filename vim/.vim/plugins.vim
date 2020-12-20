" Platform `plugged` directory
function! s:pluggedDir()
    if g:env =~ 'WINDOWS'
        return '$HOME/vimfiles/plugged'
    elseif g:env =~ 'DARWIN' || g:env =~ 'LINUX'
        return '~/.vim/plugged'
    endif
endfunction

" Plugins will be downloaded under the specified directory.
call plug#begin(s:pluggedDir())

Plug 'HerringtonDarkholme/yats.vim'
Plug 'TaDaa/vimade'
Plug 'amadeus/vim-convert-color-to'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'evanleck/vim-svelte'
Plug 'franbach/miramare'
Plug 'haishanh/night-owl.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lifepillar/vim-colortemplate'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'sheerun/vim-polyglot'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'vim-test/vim-test'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
