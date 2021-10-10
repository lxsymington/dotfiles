local dap_ui = require('dapui')
local keymap = vim.api.nvim_set_keymap
local M = {}

-- DAP UI ------------------------------
function M.setup()
	dap_ui.setup()

	keymap('n', '<Leader>du', '<Cmd>lua require("dapui").toggle()<CR>', { silent = true })
end

return M
