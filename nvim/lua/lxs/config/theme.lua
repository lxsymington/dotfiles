local opt = vim.opt
local g = vim.g
local M = {}

-- THEME -------------------------------
function M.setup()
	-- Set terminal to use true color
	if vim.fn.exists('+termguicolors') then
		opt.termguicolors = true
	end

	opt.guicursor = {
		['n-v-c'] = 'block',
		['i-ci-ve'] = 'ver25',
		['r-cr'] = 'hor20',
		o = 'hor50',
		a = 'blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
		sm = 'block-blinkwait175-blinkoff150-blinkon175',
	}

	-- Sets the background to be light
	opt.background = 'light'

	-- Sets the colorscheme to be Crepuscular
	g.colors_name = 'crepuscular'
end

return M
