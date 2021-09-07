local zen_mode = require('zen-mode')
local keymap = vim.api.nvim_set_keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	zen_mode.setup()

	keymap('n', '<Leader>zm', '<cmd>ZenMode<cr>', { silent = true, noremap = true })
end

return M
