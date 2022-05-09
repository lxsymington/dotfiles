local keymap = vim.api.nvim_set_keymap
local opt = vim.opt
local api = vim.api
local M = {}

function M.numberToggle()
	opt.nu = true

	if opt.rnu then
		opt.rnu = false
	else
		opt.rnu = true
	end
end

function M.setup()
	-- Toggle betwen normal and relative line numbers
	api.nvim_command([[ command! NumberToggle lua require('lxs.utils').Commands.numberToggle() ]])

	-- Save and execute the current file
	api.nvim_command([[ command! ReloadConfig lua ReloadConfig() ]])

	-- Keymap to quickly save and execute
	keymap('n', '<Leader>R', '<cmd>ReloadConfig<cr>', { silent = true, noremap = true })

	-- Keymap to show information about the Highlight under the cursor
	keymap(
		'n',
		'<Leader>H',
		'<cmd>TSHighlightCapturesUnderCursor<cr>',
		{ silent = true, noremap = true }
	)
end

return M
