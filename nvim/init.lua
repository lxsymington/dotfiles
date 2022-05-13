local cmd = vim.cmd

-- Builtin -----------------------------
cmd([[runtime ftplugin/man.vim]])
cmd([[runtime macros/matchit.vim]])

-- Globals -----------------------------
require('lxs.globals')

-- Config ------------------------------
require('lxs.utils').Commands()

-- Config ------------------------------
require('lxs.config').setup()

-- Plugin Dependencies -----------------
require('lxs.dependencies').setup()

-- Autocommands ------------------------
require('lxs.autocommands').setup()
