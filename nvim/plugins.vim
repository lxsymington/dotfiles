" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')

 call dein#add('~/.cache/dein')
 call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })
 call dein#add('w0rp/ale')
 call dein#add('Shougo/deoplete.nvim')
 call dein#add('Shougo/denite.nvim')
 call dein#add('hzchirs/vim-material')
 call dein#add('vim-airline/vim-airline')
 call dein#add('vim-airline/vim-airline-themes')
 call dein#add('editorconfig/editorconfig-vim')
 call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTREE'})
 call dein#add('Xuyuanp/nerdtree-git-plugin')
 call dein#add('mhinz/vim-signify')
 call dein#add('tpope/vim-surround')
 call dein#add('tpope/vim-commentary')
 call dein#add('tpope/vim-fugitive')
 call dein#add('/usr/bin/fzf')
 call dein#add('junegunn/fzf.vim')
 call dein#add('jiangmiao/auto-pairs')
 call dein#add('mattn/emmet-vim')
 call dein#add('rust-lang/rust.vim')
 call dein#add('leafgarland/typescript-vim')
 call dein#add('HerringtonDarkholme/yats.vim')
 call dein#add('Quramy/vim-js-pretty-template')
 call dein#add('mhartington/vim-typings')
 call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable
