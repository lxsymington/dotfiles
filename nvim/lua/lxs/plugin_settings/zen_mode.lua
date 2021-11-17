local zen_mode = require('zen-mode')
local wk = require('which-key')
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

	wk.register({
		['<Leader>z'] = {
			name = 'Zen mode',
			m = {
				'<cmd>ZenMode<cr>',
				'toggle',
			},
		},
	}, {
		mode = 'n',
		silent = true,
		noremap = true,
	})
end

return M
