local crepuscular_build = require("lush_theme.crepuscular_build")
local opt = vim.opt
local g = vim.g
local M = {}

-- THEME -------------------------------
function M.setup()
	-- Set terminal to use true color
	if vim.fn.exists("+termguicolors") then
		opt.termguicolors = true
	end

	opt.guicursor = {
		["n-v-c"] = "block",
		["i-ci-ve"] = "ver25",
		["r-cr"] = "hor20",
		o = "hor50",
		a = "blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
		sm = "block-blinkwait175-blinkoff150-blinkon175",
	}

	-- Sets the background to be dark
	opt.background = "dark"

	-- Sets the colorscheme to be Seoul 256 Light
	-- colorscheme seoul256-light

	-- Sets the colorscheme to be Seoul 256
	-- colorscheme seoul256

	-- Sets the colorscheme to be Crepuscular
	crepuscular_build.setup()
	g.colors_name = "crepuscular_dusk"
	-- g.colors_name = "crepuscular_dawn"
end

return M
