local commands = require('lxs.utils').Commands
local keymap = vim.keymap
local M = {}

function M.setup()
	-- Convenient normal mode
	keymap.set('i', 'jj', '<esc>', { silent = true, desc = 'Return to normal mode' })

	-- Open init.vim in a tab
	keymap.set(
		'n',
		'<Leader>ev',
		'<cmd>tabedit $MYVIMRC<cr>',
		{ silent = true, desc = 'Open $MYVIMRC in a tab' }
	)

	-- Clear highlighting
	keymap.set(
		'n',
		'<Leader>_',
		'<cmd>nohlsearch<cr>',
		{ silent = true, desc = 'Clear search highlighting' }
	)

	-- Toggle relative numbers
	keymap.set('n', '<Leader>#', function()
		commands.numberToggle()
	end, {
		silent = true,
		desc = 'Toggle relative line numbers',
	})

	-- Easier escape in integrated terminal
	keymap.set('n', '<Leader><Esc>', '<C-\\><C-n>', { silent = true, desc = 'Escape terminal' })

	-- Y yank until the end of line
	keymap.set('n', 'Y', 'y$', { desc = 'Yank to the end of the line' })

	-- Keymap to quickly save and execute
	keymap.set('n', '<Leader>R', function()
		commands.reloadConfig()
	end, {
		silent = true,
		desc = 'Reload neovim configuration',
	})

	-- Keymap to show information about the Highlight under the cursor
	keymap.set(
		'n',
		'<Leader>H',
		'<cmd>TSHighlightCapturesUnderCursor<cr>',
		{ silent = true, desc = 'Show treesitter highlight information' }
	)
end

return M
