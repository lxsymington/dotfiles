local symbols_outline = require('symbols-outline')
local keymap = vim.api.nvim_set_keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	symbols_outline.setup({})

	keymap('n', '<Leader>so', '<cmd>SymbolsOutline<cr>', { silent = true, noremap = true })
end

return M
