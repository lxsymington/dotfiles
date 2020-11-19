set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
luafile ~/.config/nvim/lua/init.lua

"------- FUNCTIONS -----------------------------------------------------------"
"Sources the functions index file
runtime! functions/index.vim

"------- ENVIRONMENT ---------------------------------------------------------"
"Sources the environment settings file
"runtime! environment.vim

"------- GENERAL -------------------------------------------------------------"
"Sources the general settings file
" runtime! general.vim

"------- PLUGIN SETTINGS -----------------------------------------------------"
"Sources the plugin settings index file
"runtime! plugin_settings/index.vim

"------- UI ------------------------------------------------------------------"
"Sources the UI settings file
runtime! ui.vim

"------- THEME ---------------------------------------------------------------"
"Sources the theme settings file
runtime! theme.vim

"------- STATUSLINE ----------------------------------------------------------"
"Sources the statusline settings file
runtime! statusline.vim

"------- HIGHLIGHTS ----------------------------------------------------------"
"Sources the highlights settings file
runtime! highlights.vim

"------- SPLITS --------------------------------------------------------------"
"Sources the splits settings file
runtime! splits.vim

"------- TABS ----------------------------------------------------------------"
"Sources the tab settings file
runtime! tabs.vim

"------- SEARCH --------------------------------------------------------------"
"Sources the search settings file
runtime! search.vim

"------- MAPPINGS ------------------------------------------------------------"
"Sources the mappings settings file
"runtime! mappings.vim

"------- MATCHIT -------------------------------------------------------------"
"Sources the Matchit Macro
runtime macros/matchit.vim
