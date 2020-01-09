" Platform `plugged` directory
function! s:pluggedDir()
    if has('nvim')
        if g:env =~ 'WINDOWS'
            return '~/AppData/Local/nvim-data'
        elseif g:env =~ 'DARWIN' || g:env =~ 'LINUX'
            return '~/.local/share/nvim'
        endif
    else
        return '~/.vim/plugged'
    endif
endfunction

" Plugins will be downloaded under the specified directory.
call plug#begin(s:pluggedDir())

Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/gv.vim'
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'rust-lang/rust.vim'
Plug 'evanleck/vim-svelte'
Plug 'TaDaa/vimade'
if has('nvim')
    Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
