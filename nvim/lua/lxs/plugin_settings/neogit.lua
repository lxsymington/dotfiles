local neogit = require('neogit')
local keymap = vim.keymap
local M = {}

-- NEOGIT ------------------------------
function M.setup()
	neogit.setup({
		signs = {
			-- { CLOSED, OPENED }
			section = { '▶', '▼' },
			item = { '▷', '▽' },
			hunk = { '▸', '▾' },
		},
		integrations = {
			diffview = true,
		},
	})

	keymap.set('n', '<Leader>ng', '<cmd>Neogit<cr>', {
		desc = 'Launch Neogit',
		silent = true,
	})
end

return M
