local neogit = require("neogit")
local keymap = vim.api.nvim_set_keymap
local M = {}

-- NEOGIT ------------------------------
function M.setup()
	neogit.setup({})

	keymap("n", "<Leader>g", "<cmd>Neogit<cr>", { silent = true, noremap = true })
end

return M
