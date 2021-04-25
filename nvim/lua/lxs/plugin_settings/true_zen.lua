local true_zen = require("true-zen")
local keymap = vim.api.nvim_set_keymap
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	true_zen.setup({
		ataraxis = {
			just_do_it_for_me = true,
		},
		integrations = {
			integration_tmux = true,
		},
	})

	keymap("n", "<Leader>zf", "<cmd>TZFocus<cr>", { silent = true, noremap = true })
	keymap("n", "<Leader>za", "<cmd>TZAtaraxis<cr>", { silent = true, noremap = true })
end

return M
