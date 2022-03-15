local wk = require("which-key")
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	wk.register({
		m = {
			'<cmd><C-U>lua require("tsht").nodes()<CR>',
			"Treesitter hop",
		},
	}, {
		mode = "o",
		silent = true,
	})
	wk.register({
		m = {
			'<cmd>lua require("tsht").nodes()<CR>',
			"Treesitter hop",
		},
	}, {
		mode = "v",
		silent = true,
		noremap = true,
	})
end

return M
