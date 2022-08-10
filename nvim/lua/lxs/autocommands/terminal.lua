local api = vim.api
local M = {}

-- TERMINAL
function M.setup()
	api.nvim_create_user_command('TerminalStyle', function()
		require('lxs.autocommands.terminal').terminalStyle()
	end, {
		desc = 'Apply terminal styles',
	})
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
