-- TERMINAL
local M = {}

function M.setup()
    if not _G.autocommand then _G.autocommand = {} end

    function _G.autocommand.terminal()
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

    vim.api.nvim_command([[
        augroup Terminal
        autocmd! * <buffer>
        autocmd TermOpen * setlocal statusline=%{b:term_title}
        autocmd TermOpen * lua autocommand.terminal() 
        augroup END
    ]])
end

return M
