local api = vim.api
local M = {}

-- Nvim Lightbulb ----------------------
function M.setup()
	api.nvim_create_augroup("Lightbulb", { clear = true })
	api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		pattern = "*",
		callback = function()
			require("nvim-lightbulb").update_lightbulb()
		end,
	})
end

return M
