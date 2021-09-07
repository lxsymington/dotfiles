local trouble = require('trouble')
local keymap = vim.api.nvim_set_keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	trouble.setup({})

	keymap('n', '<Leader>lt', '<cmd>LspTroubleToggle<cr>', { silent = true, noremap = true })
end

return M
