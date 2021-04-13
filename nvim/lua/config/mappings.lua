local imap = vim.keymap.imap
local nnoremap = vim.keymap.nnoremap
local tnoremap = vim.keymap.tnoremap
local M = {}

function M.setup()
    -- Convenient normal mode
    imap({'jj', '<esc>'})

    -- Open init.vim in a tab
    nnoremap({'<Leader>ev', function() vim.cmd('tabedit $MYVIMRC') end})

    -- Clear highlighting
    nnoremap({'<Leader>_', function() vim.cmd('nohlsearch') end})

    -- Toggle relative numbers
    nnoremap({'<Leader>#', function() vim.cmd('call NumberToggle()') end})

    tnoremap({'<Leader><Esc>', '<C-\\><C-n>'})
end

return M
