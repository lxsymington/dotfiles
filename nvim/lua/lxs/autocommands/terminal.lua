local api = vim.api
local M = {}

-- TERMINAL
function M.setup()
	api.nvim_command(
		[[ command! TerminalStyle lua require('lxs.autocommands.terminal').terminalStyle()]]
	)
end

function M.terminalStyle()
	-- Disables line numbers
	vim.opt.number = false
	vim.opt.relativenumber = false

	-- Remove the signcolumn
	vim.opt.signcolumn = 'no'

	-- Remove the foldcolumn
	vim.opt.foldcolumn = '0'
end

return M
