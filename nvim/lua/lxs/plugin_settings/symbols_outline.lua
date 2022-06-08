local symbols_outline = require('symbols-outline')
local keymap = vim.keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	symbols_outline.setup({})

	keymap.set(
		'n',
		'<Leader>so',
		'<cmd>SymbolsOutline<cr>',
		{ silent = true, desc = 'Toggle symbols outline' }
	)
end

return M
