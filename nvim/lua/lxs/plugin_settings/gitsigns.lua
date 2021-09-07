local gitsigns = require('gitsigns')
local M = {}

-- GITSIGNS ----------------------------
function M.setup()
	gitsigns.setup({
		signs = {
			add = { hl = 'GitSignsAddSign', text = '│', numhl = 'GitSignsAddNr' },
			change = { hl = 'GitSignsChangeSign', text = '┊', numhl = 'GitSignsChangeNr' },
			delete = { hl = 'GitSignsDeleteSign', text = '┴', numhl = 'GitSignsDeleteNr' },
			topdelete = { hl = 'GitSignsDeleteSign', text = '┬', numhl = 'GitSignsDeleteNr' },
			changedelete = { hl = 'GitSignsChangeSign', text = '├', numhl = 'GitSignsChangeNr' },
		},
		numhl = true,
		current_line_blame = true,
	})
end

return M
