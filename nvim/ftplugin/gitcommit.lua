-- GITCOMMIT
local M = {}

function M.setup()
	-- Force the cursor onto a new line after 120 characters
	vim.opt.textwidth = 72

	-- Creates a visual boundary
	vim.opt.colorcolumn = [[51,+1]]
end

return M
