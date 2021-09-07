local api = vim.api
local M = {}

-- TERMINAL
function M.setup()
	function TerminalStyle()
		-- Disables line numbers
		vim.opt.number = false
		vim.opt.relativenumber = false

		-- Remove the signcolumn
		vim.opt.signcolumn = 'no'

		-- Remove the foldcolumn
		vim.opt.foldcolumn = '0'
	end

	api.nvim_command([[ command! TerminalStyle lua TerminalStyle()]])
end

return M
