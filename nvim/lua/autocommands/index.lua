local M = {}

-- Autocommands Index ------------------
function M.setup()
    vim.api.nvim_command([[
        augroup Terminal
        autocmd! * <buffer>
        autocmd TermOpen * setlocal statusline=%{b:term_title}
        autocmd TermOpen * lua require('autocommands.terminal').setup() 
        augroup END
    ]])

    vim.api.nvim_command([[
        augroup HighlightYank
        autocmd! * <buffer>
        autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
        augroup END
    ]])
end

return M
