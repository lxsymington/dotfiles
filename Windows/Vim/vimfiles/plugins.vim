"======================================================================================================================"
"======= PLUGINS ======================================================================================================"
"======================================================================================================================"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/Vim/vimfiles/plugged')
Plug 'w0rp/ale',
Plug 'Shougo/deoplete.nvim',
Plug 'Shougo/denite.nvim',
Plug 'hzchirs/vim-material',
Plug 'vim-airline/vim-airline',
Plug 'vim-airline/vim-airline-themes',
Plug 'editorconfig/editorconfig-vim',
Plug 'scrooloose/nerdtree', {'on_cmd': 'NERDTREE'},
Plug 'Xuyuanp/nerdtree-git-plugin',
Plug 'mhinz/vim-signify',
Plug 'tpope/vim-surround',
Plug 'tpope/vim-commentary',
Plug 'tpope/vim-fugitive',
Plug '/usr/bin/fzf',
Plug 'junegunn/fzf.vim',
" Initialize plugin system
call plug#end()
