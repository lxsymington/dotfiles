local ls = require("luasnip")
local keymap = vim.api.nvim_set_keymap
local M = {}

-- SNIPPETS ----------------------------
function M.setup()
	ls.config.set_config()

	keymap({
		"i",
		"<Tab>",
		"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
		{
			expr = true,
			silent = true,
		},
	})

	keymap({
		"i",
		"<S-Tab>",
		"<cmd>lua require('luasnip').jump(-1)<Cr>",
		{
			noremap = true,
			silent = true,
		},
	})

	keymap({
		"s",
		"<Tab>",
		"<cmd>lua require('luasnip').jump(1)<Cr>",
		{
			noremap = true,
			silent = true,
		},
	})

	keymap({
		"s",
		"<S-Tab>",
		"<cmd>lua require('luasnip').jump(-1)<Cr>",
		{
			noremap = true,
			silent = true,
		},
	})

	keymap({
		"i",
		"<C-E>",
		"luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
		{
			expr = true,
			silent = true,
		},
	})

	keymap({
		"s",
		"<C-E>",
		"luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
		{
			expr = true,
			silent = true,
		},
	})
end

return M
