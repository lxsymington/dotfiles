" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'w0rp/ale'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
if has('nvim')
    Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
