local lightbulb = require('nvim-lightbulb')
local M = {}

-- LIGHTBULB ---------------------------
function M.setup()
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua lightbulb.update_lightbulb()]]
end

return M
