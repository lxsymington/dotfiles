-- vim.o.runtimepath = [[~/.vim]] .. vim.o.runtimepath .. [[~/.vim/after]]
-- vim.g.packpath = vim.o.runtimepath
vim.cmd([[runtime macros/matchit.vim]])

-- Config ------------------------------
require('config.index').setup()

-- Plugins -----------------------------
require('plugins')
