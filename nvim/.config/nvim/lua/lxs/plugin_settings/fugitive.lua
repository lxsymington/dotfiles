local M = {}

-- FUGITIVE ----------------------------
function M.setup()
	if vim.g.env == 'WINDOWS' then
		vim.g.fugitive_git_executable = 'C:\\ProgramData\\scoop\\shims\\git'
	end
end

return M
