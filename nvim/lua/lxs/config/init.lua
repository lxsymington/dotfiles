local M = {}

-- Config Index ------------------------
function M.setup()
	require("lxs.config.environment").setup()
	require("lxs.config.external").setup()
	require("lxs.config.base").setup()
	require("lxs.config.mappings").setup()
	require("lxs.config.ui").setup()
	require("lxs.config.theme").setup()
	require("lxs.config.utils").setup()
end

return M
