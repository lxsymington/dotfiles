local terminal = require('lxs.autocommands.terminal')
local M = {}

-- Autocommands Index ------------------
function M.setup()
	terminal.setup()

	vim.api.nvim_exec(
		[[
            augroup Terminal
            autocmd!
            autocmd TermOpen,TermEnter <buffer> TerminalStyle
            autocmd BufNew term://* TerminalStyle
            augroup END
        ]],
		false
	)

	vim.api.nvim_exec(
		[[
            augroup HighlightYank
            autocmd!
            autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
            augroup END
        ]],
		false
	)

	vim.api.nvim_exec(
		[[
            augroup ReloadConfig
            autocmd!
            autocmd BufWritePost */nvim/lua/**,*/nvim/lush_theme/** ++once ReloadConfig
            augroup END
        ]],
		false
	)
end

return M
