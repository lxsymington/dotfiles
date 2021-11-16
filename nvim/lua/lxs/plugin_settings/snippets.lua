local ls = require('luasnip')
local cmp = require('cmp')
local keymap = vim.api.nvim_set_keymap
local M = {}

local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
			== nil
end



-- SNIPPETS ----------------------------
function M.setup()
	ls.config.set_config({
		history = true,
	})

	keymap('i', '<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", {
		expr = true,
		silent = true,
	})

	keymap('i', '<S-Tab>', "<cmd>lua require('luasnip').jump(-1)<Cr>", {
		noremap = true,
		silent = true,
	})

	keymap('s', '<Tab>', "<cmd>lua require('luasnip').jump(1)<Cr>", {
		noremap = true,
		silent = true,
	})

	keymap('s', '<S-Tab>', "<cmd>lua require('luasnip').jump(-1)<Cr>", {
		noremap = true,
		silent = true,
	})

	keymap('i', '<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", {
		expr = true,
		silent = true,
	})

	keymap('s', '<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", {
		expr = true,
		silent = true,
	})
end

return M
