-- TERMINAL
local M = {}

local function term_config()
    -- Disables line numbers
    vim.wo.number = false
    vim.wo.relativenumber = false

    -- Remove the signcolumn
    vim.wo.signcolumn = 'no'

    -- Remove the foldcolumn
    vim.wo.foldcolumn = '0'
end

function M.setup()
    vim.api.nvim_command [[augroup Terminal]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd TermOpen <buffer> lua term_config() ]]
    vim.api.nvim_command [[augroup END]]
end

return M
