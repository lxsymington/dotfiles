local keymap = vim.keymap
local M = {}

-- Sniprun -----------------------------
function M.setup()
	require('sniprun').setup({
		display = { 'NvimNotify' },
		show_no_output = { 'NvimNotify' },
		borders = 'rounded',
	})

	keymap.set('n', '<Leader>e', '<Plug>SnipRunOperator', {
		desc = 'Sniprun Execute Over Operator',
		silent = true,
	})
	keymap.set('n', '<Leader>E', '<Plug>SnipRun', {
		desc = 'Sniprun Execute File',
		silent = true,
	})
	keymap.set('v', '<Tab>', '<Plug>Sniprun', {
		desc = 'Sniprun Execute Selection',
		silent = true,
	})
end

return M
