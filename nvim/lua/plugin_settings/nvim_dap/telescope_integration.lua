local M = {}

-- NVIM-DAP TELESCOPE INTEGRATION ------
function M.setup()
    telescope.load_extension('dap')

    -- Debug Commands
    vim.cmd
        [[command! DebugCommands lua require('telescope').extensions.dap.commands()]]

    -- Debug Configurations
    vim.cmd
        [[command! DebugConfigurations lua require('telescope').extensions.dap.configurations()]]

    -- Debug List Breakpoints
    vim.cmd
        [[command! DebugListBreakpoints lua require('telescope').extensions.dap.list_breakpoints()]]

    -- Debug Varaibles (Watch Variables?)
    vim.cmd
        [[command! DebugVariables lua require('telescope').extensions.dap.variables()]]
end

return M
