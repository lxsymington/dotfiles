local neogit = require('neogit')
local wk = require('which-key')
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

	wk.register({
		['<Leader>ng'] = {
			'<cmd>Neogit<cr>',
			'Launch Neogit',
		},
	}, {
		mode = 'n',
		silent = true,
		noremap = true,
	})
end

return M
