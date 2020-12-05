local telescope = require('telescope')
local vimp = require('vimp')
local M = {}

-- NVIM-DAP TELESCOPE INTEGRATION ------
function M.setup()
    telescope.load_extension('dap')

    -- Debug Commands
    vimp.map_command('DebugCommands', function()
        telescope.extensions.dap.commands()
    end)

    -- Debug Configurations
    vimp.map_command('DebugConfigurations', function()
        telescope.extensions.dap.configurations()
    end)

    -- Debug List Breakpoints
    vimp.map_command('DebugListBreakpoints', function()
        telescope.extensions.dap.list_breakpoints()
    end)

    -- Debug Varaibles (Watch Variables?)
    vimp.map_command('DebugVariables', function()
        telescope.extensions.dap.variables()
    end)
end

return M
