local zen_mode = require('zen-mode')
local keymap = vim.api.nvim_set_keymap
local o = vim.o
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	zen_mode.setup({
		window = {
			width = math.min(math.floor(o.columns * 0.8), 120),
			height = math.min(math.floor(o.lines * 0.67), 400),
		},
	})

	keymap('n', '<Leader>zm', '<cmd>ZenMode<cr>', { silent = true, noremap = true })
end

return M
