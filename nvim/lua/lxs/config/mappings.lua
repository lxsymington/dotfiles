local keymap = vim.api.nvim_set_keymap
local M = {}

function M.setup()
	-- Convenient normal mode
	keymap("i", "jj", "<esc>", { silent = true })

	-- Open init.vim in a tab
	keymap("n", "<Leader>ev", "<cmd>tabedit $MYVIMRC<cr>", { silent = true, noremap = true })

	-- Clear highlighting
	keymap("n", "<Leader>_", "<cmd>nohlsearch<cr>", { silent = true, noremap = true })

	-- Toggle relative numbers
	keymap("n", "<Leader>#", "<cmd>call NumberToggle()<cr>", { silent = true, noremap = true })

	-- Easier escape in integrated terminal
	keymap("n", "<Leader><Esc>", "<C-\\><C-n>", { silent = true, noremap = true })

	-- Y yank until the end of line
	keymap("n", "Y", "y$", { noremap = true })
end

return M
