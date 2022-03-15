local dap_ui = require('dapui')
local wk = require('which-key')
local M = {}

-- DAP UI ------------------------------
function M.setup()
	dap_ui.setup({
		sidebar = {
			elements = {
				{ id = 'scopes', size = 0.5 },
				{ id = 'stacks', size = 0.25 },
				{ id = 'breakpoints', size = 0.125 },
				{ id = 'watches', size = 0.125 },
			},
			size = 60,
		},
		tray = {
			elements = { 'repl' },
			size = 10,
			position = 'bottom',
		},
	})

	wk.register({
		['<Leader>D'] = {
			name = 'DAP',
			u = {
				'<Cmd>lua require("dapui").toggle()<CR>',
				'toggle UI',
			},
		},
	}, {
		mode = 'n',
		silent = true,
	})
end

return M
