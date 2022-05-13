local api = vim.api
local M = {}

-- Nvim Lightbulb ----------------------
function M.setup()
	local lightbulb_group = api.nvim_create_augroup('Lightbulb', { clear = true })
	api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		pattern = '*',
		callback = function()
			require('nvim-lightbulb').update_lightbulb()
		end,
		group = lightbulb_group,
	})
end

return M
