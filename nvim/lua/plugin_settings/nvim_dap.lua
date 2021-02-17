local dap = require('dap')
local nnoremap = vim.keymap.nnoremap
local M = {}

-- DAP ---------------------------------
function M.setup()
    -- Node debugger
    dap.adapters.node = require('plugin_settings.nvim_dap.adapters.node')
    dap.configurations.node = {
        require('plugin_settings.nvim_dap.configurations.mocha_tests_workspace'),
        require('plugin_settings.nvim_dap.configurations.mocha_tests_file'),
        require('plugin_settings.nvim_dap.configurations.jest_tests_workspace'),
        require('plugin_settings.nvim_dap.configurations.jest_tests_file')
    }
    dap.configurations.typescript = {
        require(
            'plugin_settings.nvim_dap.configurations.mocha_typescript_tests_workspace'),
        require(
            'plugin_settings.nvim_dap.configurations.mocha_typescript_tests_file'),
        require('plugin_settings.nvim_dap.configurations.jest_tests_workspace'),
        require('plugin_settings.nvim_dap.configurations.jest_tests_file')
    }

    -- Allow `nvim-dap` to attempt to load settings from VSCode's launch.json
    vim.cmd [[command! DebugLoadLaunchJS lua require('dap.ext.vscode').load_launchjs()]]

    -- Set up mappings for `nvim-dap`
    -- CONTINUE
    nnoremap({'<F5>', dap.continue})
    -- STEP OVER
    nnoremap({'<F10>', dap.step_over})
    -- STEP INTO
    nnoremap({'<F11>', dap.step_into})
    -- STEP OUT
    nnoremap({'<F12>', dap.step_out})
    -- TOGGLE BREAKPOINT
    nnoremap({'<Leader>b', dap.toggle_breakpoint})
    -- SET CONDITIONAL BREAKPOINT
    nnoremap({'<Leader>B', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end})
    -- SET LOGPOINT
    nnoremap({'<Leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end})
    -- OPEN DEBUGGER CONSOLE
    nnoremap({'<Leader>dr', dap.repl.open})
    -- RE-RUN LAST DEBUGGING SESSION
    nnoremap({'<Leader>dl', dap.repl.run_last})

    -- Show virtual text for current frame
    vim.g.dap_virtual_text = true
end

return M
