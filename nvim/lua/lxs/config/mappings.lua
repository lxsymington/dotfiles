local commands = require('lxs.utils').Commands
local keymap = vim.keymap
local M = {}

function M.setup()
    -- Convenient normal mode
    keymap.set('i', 'jj', '<esc>', { silent = true })

    -- Open init.vim in a tab
    keymap.set('n', '<Leader>ev', '<cmd>tabedit $MYVIMRC<cr>', { silent = true })

    -- Clear highlighting
    keymap.set('n', '<Leader>_', '<cmd>nohlsearch<cr>', { silent = true })

    -- Toggle relative numbers
    keymap.set('n', '<Leader>#', function()
        commands.numberToggle()
    end, { silent = true })

    -- Easier escape in integrated terminal
    keymap.set('n', '<Leader><Esc>', '<C-\\><C-n>', { silent = true })

    -- Y yank until the end of line
    keymap.set('n', 'Y', 'y$')

    -- Keymap to quickly save and execute
    keymap.set('n', '<Leader>R', function()
        commands.reloadConfig()
    end, { silent = true })

    -- Keymap to show information about the Highlight under the cursor
    keymap.set(
        'n',
        '<Leader>H',
        '<cmd>TSHighlightCapturesUnderCursor<cr>',
        { silent = true }
    )
end

return M
