" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'w0rp/ale'
Plug 'hzchirs/vim-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'mhinz/vim-signify'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
