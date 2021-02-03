-- vim.o.runtimepath = [[~/.vim]] .. vim.o.runtimepath .. [[~/.vim/after]]
-- vim.g.packpath = vim.o.runtimepath
vim.cmd([[runtime ftplugin/man.vim]])
vim.cmd([[runtime macros/matchit.vim]])

-- Plugins -----------------------------
require('plugins')

-- Config ------------------------------
require('config.index').setup()

-- Autocommands ------------------------
require('autocommands.index').setup()
