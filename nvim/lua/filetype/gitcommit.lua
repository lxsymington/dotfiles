-- GITCOMMIT
local M = {}

function M.setup()
    -- Force the cursor onto a new line after 120 characters
    vim.bo.textwidth = 72

    -- Creates a visual boundary
    vim.wo.colorcolumn = [[53,+1]]
end

return M
