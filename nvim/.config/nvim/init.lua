local cmd = vim.cmd

-- Builtin -----------------------------
cmd([[runtime ftplugin/man.vim]])
cmd([[runtime macros/matchit.vim]])

-- Config ------------------------------
require('lxs.utils').Commands.setup()

-- Config ------------------------------
require('lxs.config').setup()

-- Plugin Dependencies -----------------
require('lxs.dependencies').setup()

-- Autocommands ------------------------
require('lxs.autocommands').setup()
