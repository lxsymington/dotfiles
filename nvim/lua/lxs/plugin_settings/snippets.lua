local snippets = require("snippets")
local inoremap = vim.keymap.inoremap
local M = {}

-- SNIPPETS ----------------------------
function M.setup()
	snippets.use_suggested_mappings()

	inoremap({ "<Leader>p", function()
		snippets.expand_or_advance(1)
	end })
	inoremap({ "<Leader>n", function()
		snippets.advance_snippet(-1)
	end })

	snippets.snippets = {}
end

return M
