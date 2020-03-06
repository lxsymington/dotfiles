" Platform `plugged` directory
function! s:pluggedDir()
    if has('nvim')
        if g:env =~ 'WINDOWS'
            return '~/AppData/Local/nvim-data/plugged'
        elseif g:env =~ 'DARWIN' || g:env =~ 'LINUX'
            return '~/.local/share/nvim/plugged'
        endif
    else
        return '~/.vim/plugged'
    endif
endfunction

" Plugins will be downloaded under the specified directory.
call plug#begin(s:pluggedDir())

Plug 'HerringtonDarkholme/yats.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'TaDaa/vimade'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'evanleck/vim-svelte'
Plug 'haishanh/night-owl.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'lambdalisue/fern.vim'
Plug 'leafgarland/typescript-vim'
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psliwka/vim-smoothie'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
