local trouble = require('trouble')
local keymap = vim.keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	trouble.setup({})

    keymap.set('n', '<Leader>lt', '<cmd>TroubleToggle<cr>', {
        desc = 'Toggle LSP Trouble',
        silent = true,
    })
end

return M
