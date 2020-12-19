local vimp = require('vimp')
local M = {}

function M.setup()
    -- Convenient normal mode
    vimp.imap('jj', '<esc>')

    -- Switch pane postion shortcuts
    vimp.nnoremap('<C-J>', '<C-w><C-J>')
    vimp.nnoremap('<C-K>', '<C-w><C-K>')
    vimp.nnoremap('<C-H>', '<C-w><C-H>')
    vimp.nnoremap('<C-L>', '<C-w><C-L>')

    -- Open init.vim in a tab
    vimp.nnoremap('<Leader>ev', function() vim.cmd('tabedit $MYVIMRC') end)

    -- CLear highlighting
    vimp.nnoremap('<Leader><space>', function() vim.cmd('nohlsearch') end)

    -- Toggle relative numbers
    vimp.nnoremap('<Leader>#', function() vim.cmd('call NumberToggle()') end)

    vimp.tnoremap('<Leader><Esc>', '<C-\\><C-n>')
end

return M
