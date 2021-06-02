local api = vim.api
local M = {}

-- TERMINAL
function M.setup()
	function TerminalStyle()
		-- Disables line numbers
		vim.wo.number = false
		vim.wo.relativenumber = false

		-- Remove the signcolumn
		vim.wo.signcolumn = "no"

		-- Remove the foldcolumn
		vim.wo.foldcolumn = "0"
	end

	api.nvim_command([[ command! TerminalStyle lua TerminalStyle()]])
end

return M
