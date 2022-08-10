local keymap = vim.keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	keymap.set('o', 'm', function()
		require('tsht').nodes()
	end, {
		desc = 'Treesitter Hop',
		silent = true,
		remap = true,
	})
	keymap.set('x', 'm', function()
		require('tsht').nodes()
	end, {
		desc = 'Treesitter Hop',
		silent = true,
	})
end

return M
