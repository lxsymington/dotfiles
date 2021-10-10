local terminal = require('lxs.autocommands.terminal')
local M = {}

-- Autocommands Index ------------------
function M.setup()
	terminal.setup()

	vim.api.nvim_exec(
		[[
            augroup Terminal
            autocmd TermOpen,TermEnter <buffer> TerminalStyle
            augroup END
        ]],
		false
	)

	vim.api.nvim_exec(
		[[
            augroup HighlightYank
            autocmd TextYankPost <buffer> silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
            augroup END
        ]],
		false
	)

	vim.api.nvim_exec(
		string.format(
			[[
                augroup ReloadConfig
                autocmd BufWritePost %s silent! ReloadConfig
                augroup END
            ]],
			os.getenv('HOME') .. '/.config/nvim/*.lua'
		),
		false
	)
end

return M
