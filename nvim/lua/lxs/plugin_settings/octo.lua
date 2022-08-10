local octo = require('octo')
local keymap = vim.keymap
local M = {}

function M.setup()
	octo.setup({
		ssh_aliases = {
			Seccl = 'github.com',
			Personal = 'github.com',
		},
	})

	keymap.set('n', '<Leader>Sr', function()
		vim.cmd('Octo search is:pr review-requested:@me state:open')
	end, {
		desc = 'Octo » Requested Reviews',
		silent = true,
	})
end

return M
