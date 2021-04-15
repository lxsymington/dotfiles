-- Autocommands Index ------------------
local function autocommand_setup()
    vim.api.nvim_command [[
        augroup Terminal
        autocmd! * <buffer>
        autocmd TermOpen <buffer> setlocal statusline=%{b:term_title}
        autocmd TermOpen <buffer> lua require('lxs.autocommands.terminal').setup() 
        augroup END
    ]]

    vim.api.nvim_command [[
        augroup HighlightYank
        autocmd! * <buffer>
        autocmd TextYankPost <buffer> silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
        augroup END
    ]]
end

return autocommand_setup()
