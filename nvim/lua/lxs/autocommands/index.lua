-- Autocommands Index ------------------
local function autocommand_setup()
	vim.api.nvim_exec(
		[[
        augroup Terminal
        autocmd!
        autocmd TermOpen <buffer> setlocal statusline=%{b:term_title}
        autocmd TermOpen <buffer> lua require('lxs.autocommands.terminal').setup() 
        augroup END
    ]],
		false
	)

	vim.api.nvim_exec(
		[[
        augroup HighlightYank
        autocmd!
        autocmd TextYankPost <buffer> silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
        augroup END
    ]],
		false
	)
end

return autocommand_setup()
