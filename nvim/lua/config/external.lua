local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local fn = vim.fn
local M = {}

-- External
function M.setup()
    -- Use ripgrep instead of grep
    o.grepprg = [[rg --vimgrep --no-heading --smart-case]]
    o.grepformat = [[%f:%l:%c:%m,%f:%l:%m]]
end

return M
