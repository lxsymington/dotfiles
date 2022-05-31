local cmd = vim.api.nvim_create_user_command
local M = {}

-- NVIM-DAP TELESCOPE INTEGRATION ------
function M.setup()
	require('telescope').load_extension('dap')

	-- Debug Commands
	cmd('DebugCommands', require('telescope').extensions.dap.commands, {})

	-- Debug Configurations
	cmd('DebugConfigurations', require('telescope').extensions.dap.configurations, {})

	-- Debug List Breakpoints
	cmd('DebugListBreakpoints', require('telescope').extensions.dap.list_breakpoints, {})

	-- Debug Varaibles (Watch Variables?)
	cmd('DebugVariables', require('telescope').extensions.dap.variables, {})
end

return M
