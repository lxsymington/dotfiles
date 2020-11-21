set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
luafile ~/.config/nvim/lua/init.lua

"------- STATUSLINE ----------------------------------------------------------"
"Sources the statusline settings file
runtime! statusline.vim

"------- MATCHIT -------------------------------------------------------------"
"Sources the Matchit Macro
runtime macros/matchit.vim
