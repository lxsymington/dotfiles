local keymap = vim.api.nvim_set_keymap
local M = {}

-- Notify ------------------------------
function M.setup()
	vim.notify = require('notify')

	local telescope_available, _ = pcall(require, 'telescope')
	if telescope_available then
		keymap(
			'n',
			'<Leader>n',
			'<Cmd>lua require("telescope").extensions.notify.notify()',
			{ noremap = true, silent = true }
		)
	end
end

return M
