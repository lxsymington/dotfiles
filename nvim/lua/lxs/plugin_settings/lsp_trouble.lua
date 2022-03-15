local trouble = require("trouble")
local wk = require("which-key")
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	trouble.setup({})

	wk.register({
		["<Leader>lt"] = {
			"<cmd>LspTroubleToggle<cr>",
			"Toggle LSP Trouble",
		},
	}, {
		mode = "n",
		silent = true,
		noremap = true,
	})
end

return M
