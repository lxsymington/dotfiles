local neogen = require('neogen')
local wk = require('which-key')
local M = {}

-- NEOGEN ------------------------------
function M.setup()
	neogen.setup({
		enable = true,
	})

	wk.register({
		['['] = {
			a = {
				'<Cmd>lua require("neogen").jump_prev()<CR>',
				'Previous annotation',
			},
		},
		[']'] = {
			a = {
				'<Cmd>lua require("neogen").jump_next()<CR>',
				'Next annotation',
			},
		},
		['<Leader>'] = {
			a = {
				name = 'Annotate',
				d = {
					'<cmd>lua require("neogen").generate()<CR>',
					'Documentation',
				},
			},
		},
	}, {
		mode = 'n',
		silent = true,
		noremap = true,
	})
end

return M
