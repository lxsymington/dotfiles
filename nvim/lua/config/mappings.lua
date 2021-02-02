local vimp = require('vimp')
local M = {}

function M.setup()
    -- Convenient normal mode
    vimp.imap('jj', '<esc>')

    -- Open init.vim in a tab
    vimp.nnoremap('<Leader>ev', function() vim.cmd('tabedit $MYVIMRC') end)

    -- CLear highlighting
    vimp.nnoremap('<Leader>_', function() vim.cmd('nohlsearch') end)

    -- Toggle relative numbers
    vimp.nnoremap('<Leader>#', function() vim.cmd('call NumberToggle()') end)

    vimp.tnoremap('<Leader><Esc>', '<C-\\><C-n>')
end

return M
