local cmd = vim.cmd

-- Builtin -----------------------------
cmd [[runtime ftplugin/man.vim]]
cmd [[runtime macros/matchit.vim]]

-- Astronauta --------------------------
cmd [[runtime plugin/astronauta.vim]]

-- Globals -----------------------------
require('lxs.globals')

-- Plugin Dependencies -----------------
require('lxs.dependencies')

-- Autocommands ------------------------
require('lxs.autocommands.index')

-- Config ------------------------------
require('lxs.config.index')
