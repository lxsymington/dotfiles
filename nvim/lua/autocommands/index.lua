local M = {}

-- Autocommands Index ------------------
function M.setup()
    print('Setting up autocommands...')

    vim.api.nvim_command [[
        augroup Terminal
        autocmd! * <buffer>
        autocmd TermOpen <buffer> setlocal statusline=%{b:term_title}
        autocmd TermOpen <buffer> lua require('autocommands.terminal').setup() 
        augroup END
    ]]

    vim.api.nvim_command [[
        augroup HighlightYank
        autocmd! * <buffer>
        autocmd TextYankPost <buffer> silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
        augroup END
    ]]
end

return M
