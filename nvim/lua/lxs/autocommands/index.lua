local terminal = require("lxs.autocommands.terminal")

-- Autocommands Index ------------------
local function autocommand_setup()
	terminal.setup()

	vim.api.nvim_exec(
		[[
			augroup Terminal
			autocmd!
			autocmd TermOpen <buffer> setlocal statusline=%{b:term_title}
			autocmd TermOpen <buffer> TerminalStyle
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
