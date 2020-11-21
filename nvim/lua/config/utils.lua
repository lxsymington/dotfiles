local vimp = require('vimp')
local M = {}

function M.setup()
    -- Toggle betwen normal and relative line numbers
    vimp.map_command('NumberToggle', function()
        vim.o.nu = true
        if vim.wo.rnu then
            vim.wo.rnu = false
        else
            vim.wo.rnu = true
        end
    end)
end

return M
