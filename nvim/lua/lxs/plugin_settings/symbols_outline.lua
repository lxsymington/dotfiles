local symbols_outline = require("symbols-outline")
local wk = require("which-key")
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	symbols_outline.setup({})

	wk.register({
		["<Leader>so"] = {
			"<cmd>SymbolsOutline<cr>",
			"Toggle symbols outline",
		},
	}, {
		mode = "n",
		silent = true,
		noremap = true,
	})
end

return M
