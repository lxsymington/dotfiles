local opt = vim.opt
local M = {}

-- External
function M.setup()
	-- Use ripgrep instead of grep
	opt.grepprg = [[rg --vimgrep --no-heading --smart-case]]
	opt.grepformat = [[%f:%l:%c:%m,%f:%l:%m]]
end

return M
