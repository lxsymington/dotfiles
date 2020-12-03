local dap = require('dap')
local M = {}

-- DAP ---------------------------------
function M.setup()
    -- Node debugger
    dap.adapters.node = require('plugin_settings.nvim-dap.node')

    -- Show virtual text for current frame
    vim.g.dap_virtual_text = true
end

return M
