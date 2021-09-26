local keymap = vim.api.nvim_set_keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	keymap('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>', { silent = true })
	keymap('v', 'm', ':lua require("tsht").nodes()<CR>', { silent = true, noremap = true })
end

return M
