local neogen = require('neogen')
local keymap = vim.keymap
local M = {}

-- NEOGEN ------------------------------
function M.setup()
	neogen.setup({
		enable = true,
		input_after_comment = true,
		snippet_engine = 'luasnip',
	})

    keymap.set('n', ']a', function ()
        require("neogen").jump_next()
    end, { desc = 'Next » Annotation', silent = true })
    keymap.set('n', '[a', function ()
        require("neogen").jump_prev()
    end, { desc = 'Previous » Annotation', silent = true })
    keymap.set('n', '<Leader>ad', function ()
        require("neogen").generate({})
    end, { desc = 'Annotate » Documentation' })
end

return M
