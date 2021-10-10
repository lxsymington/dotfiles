local api = vim.api
local M = {}

-- Nvim Lightbulb ----------------------
function M.setup()
	api.nvim_exec(
		[[
		    augroup Lightbulb
		    autocmd!
            autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
            augroup END
        ]],
		false
	)
end

return M
