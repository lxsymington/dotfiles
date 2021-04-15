-- TERMINAL
local M = {}

function M.setup()
    print('Applying terminal config...')

    -- Disables line numbers
    vim.wo.number = false
    vim.wo.relativenumber = false

    -- Remove the signcolumn
    vim.wo.signcolumn = 'no'

    -- Remove the foldcolumn
    vim.wo.foldcolumn = '0'
end

return M
