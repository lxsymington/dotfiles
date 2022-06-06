local refactoring = require('refactoring')
local keymap = vim.keymap
local M = {}

function M.setup()
	refactoring.setup({})

    keymap.set('v', '<Leader>aref', function ()
        require('refactoring').refactor('Extract Function')
    end, { desc = 'Analysis » Refactor » Extract » Function', silent = true })
    keymap.set('v', '<Leader>areF', function ()
        require('refactoring').refactor('Extract Function To File')
    end, { desc = 'Analysis » Refactor » Extract » Function To File', silent = true })
    keymap.set('v', '<Leader>arev', function ()
        require('refactoring').refactor('Extract Variable')
    end, { desc = 'Analysis » Refactor » Extract » Variable', silent = true })
    keymap.set('v', '<Leader>ariv', function ()
        require('refactoring').refactor('Inline Variable')
    end, { desc = 'Analysis » Refactor » Inline » Variable', silent = true })
    keymap.set('v', '<Leader>ars', function ()
        require('refactoring').select_refactor()
    end, { desc = 'Analysis » Refactor » Select', silent = true })
    keymap.set('n', '<Leader>areb', function ()
        require('refactoring').refactor('Extract Block')
    end, { desc = 'Analysis » Refactor » Extract » Block', silent = true })
    keymap.set('n', '<Leader>areB', function ()
        require('refactoring').refactor('Extract Block To File')
    end, { desc = 'Analysis » Refactor » Extract » Block To File', silent = true })
    keymap.set('n', '<Leader>ariv', function ()
        require('refactoring').refactor('Inline Variable')
    end, { desc = 'Analysis » Refactor » Inline » Variable', silent = true })
end

return M
