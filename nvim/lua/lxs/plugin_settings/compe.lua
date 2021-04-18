local compe = require("compe")
local api = vim.api

local M = {}

-- COMPE -------------------------------
function M.setup()
	require("compe").setup({
		enabled = true,
		autocomplete = true,
		debug = false,
		min_length = 1,
		preselect = "enable",
		throttle_time = 80,
		source_timeout = 200,
		incomplete_delay = 400,
		max_abbr_width = 100,
		max_kind_width = 100,
		max_menu_width = 100,
		documentation = true,

		source = {
			path = true,
			buffer = true,
			calc = true,
			nvim_lsp = true,
			nvim_lua = true,
			vsnip = true,
		},
	})

	api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, expr = true, silent = true })
	api.nvim_set_keymap("i", "<C-y>", "compe#confirm()", { noremap = true, expr = true, silent = true })
	api.nvim_set_keymap("i", "<C-e>", "compe#close()", { noremap = true, expr = true, silent = true })
	api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta' = +4 })", { noremap = true, expr = true, silent = true })
	api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta' = -4 })", { noremap = true, expr = true, silent = true })
end

return M
