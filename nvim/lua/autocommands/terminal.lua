-- TERMINAL
local M = {}

function M.setup()
    -- Disables line numbers
    vim.o.number = false
    vim.wo.number = false
    vim.o.relativenumber = false
    vim.wo.relativenumber = false

    -- Remove the signcolumn
    vim.o.signcolumn = 'no'
    vim.wo.signcolumn = 'no'

    -- Remove the foldcolumn
    vim.o.foldcolumn = '0'
    vim.wo.foldcolumn = '0'
end

return M
