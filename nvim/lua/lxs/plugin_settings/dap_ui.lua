local dap_ui = require('dapui')
local keymap = vim.keymap
local M = {}

-- DAP UI ------------------------------
function M.setup()
    dap_ui.setup({
        layouts = {
            {
                elements = {
                    { id = 'scopes', size = 0.5 },
                    { id = 'stacks', size = 0.25 },
                    { id = 'breakpoints', size = 0.125 },
                    { id = 'watches', size = 0.125 },
                },
                size = 60,
                position = 'left',
            },
            {
                elements = {
                    'repl',
                    'console',
                },
                size = 10,
                position = 'bottom',
            },
        },
    })

    keymap.set('n', '<Leader>D', function()
        require('dapui').toggle({})
    end, {
        silent = true,
        desc = 'DAP » toggle UI',
    })
end

return M
