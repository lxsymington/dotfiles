-- TERMINAL
local M = {}

if not _G.autocommand then _G.autocommand = {} end

function _G.autocommand.terminal()
    -- Disables line numbers
    vim.wo.number = false
    vim.wo.relativenumber = false

    -- Remove the signcolumn
    vim.wo.signcolumn = 'no'

    -- Remove the foldcolumn
    vim.wo.foldcolumn = '0'
end

function M.setup()
    vim.api.nvim_command([[
        augroup Terminal
        autocmd! * <buffer>
        autocmd TermOpen * v:lua.autocommand.terminal() 
        augroup END
    ]])
end

return M
