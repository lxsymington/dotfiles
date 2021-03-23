local cmd = vim.cmd

-- Builtin -----------------------------
cmd [[runtime ftplugin/man.vim]]
cmd [[runtime macros/matchit.vim]]

-- Astronauta --------------------------
cmd [[runtime plugin/astronauta.vim]]

-- Plugins -----------------------------
require('plugins')

-- Autocommands ------------------------
require('autocommands.index').setup()

-- Config ------------------------------
require('config.index').setup()
