local zen_mode = require('zen-mode')
local keymap = vim.keymap
local o = vim.o
local M = {}

-- TROUBLE -----------------------------
function M.setup()
	zen_mode.setup({
		window = {
			width = math.min(math.floor(o.columns * 0.8), 150),
			height = math.min(o.lines, 400),
		},
	})

    keymap.set('n', '<Leader>zm', '<cmd>ZenMode<cr>', {
        desc = 'Zen Mode » Toggle',
        silent = true
    })
end

return M
