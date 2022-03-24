local wk = require('which-key')
local keymap = vim.api.nvim_set_keymap
local M = {}

-- Sniprun -----------------------------
function M.setup()
	require('sniprun').setup({
		display = { 'NvimNotify' },
		show_no_output = { 'NvimNotify' },
		borders = 'rounded',
	})

	wk.register({
	    ['<Leader>'] = {
	        e = {
	            '<Plug>SnipRunOperator',
	            'Sniprun execute over operator'
            },
	        E = {
                '<Plug>Sniprun',
	            'Sniprun execute file'
            },
        },
	}, { mode = 'n', noremap = true, silent = true })
	local keymap_opts = {}
	keymap('v', '<Tab>', '<Plug>Sniprun', keymap_opts)
end

return M
