local dap = require('dap')
local vimp = require('vimp')
local M = {}

-- DAP ---------------------------------
function M.setup()
    -- Node debugger
    dap.adapters.node = require('plugin_settings.nvim-dap.adapters.node')
    dap.configurations.node = {
        require('plugin_settings.nvim-dap.configurations.mocha_tests')
    }
    dap.configurations.typescript = {
        require('plugin_settings.nvim-dap.configurations.typescript_mocha_tests'),
        require('plugin_settings.nvim-dap.configurations.jest_tests_workspace'),
        require('plugin_settings.nvim-dap.configurations.jest_tests_file')
    }

    -- Allow `nvim-dap` to attempt to load settings from VSCode's launch.json
    vimp.map_command('DebugLoadLaunchJS',
                     function() require('dap.ext.vscode').load_launchjs() end)

    -- Set up mappings for `nvim-dap`
    -- CONTINUE
    vimp.nnoremap({'silent'}, [[<F5>]], function() dap.continue() end)
    -- STEP OVER
    vimp.nnoremap({'silent'}, [[<F10>]], function() dap.step_over() end)
    -- STEP INTO
    vimp.nnoremap({'silent'}, [[<F11>]], function() dap.step_into() end)
    -- STEP OUT
    vimp.nnoremap({'silent'}, [[<F12>]], function() dap.step_out() end)
    -- TOGGLE BREAKPOINT
    vimp.nnoremap({'silent'}, [[<Leader>b]],
                  function() dap.toggle_breakpoint() end)
    -- SET CONDITIONAL BREAKPOINT
    vimp.nnoremap({'silent'}, [[<Leader>B]], function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end)
    -- SET LOGPOINT
    vimp.nnoremap({'silent'}, [[<Leader>lp]], function()
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end)
    -- OPEN DEBUGGER CONSOLE
    vimp.nnoremap({'silent'}, [[<Leader>dr]], function() dap.repl.open() end)
    -- RE-RUN LAST DEBUGGING SESSION
    vimp.nnoremap({'silent'}, [[<Leader>dl]], function() dap.repl.run_last() end)

    -- Show virtual text for current frame
    vim.g.dap_virtual_text = true
end

return M
