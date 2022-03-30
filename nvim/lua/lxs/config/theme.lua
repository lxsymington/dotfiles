local colours = require(vim.g.colors_name .. '.colours')
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

	-- Sets the background to be dark
	opt.background = 'light'

	-- Sets the colorscheme to be Crepuscular
	g.colors_name = 'crepuscular'
end

---A unique key under which a theme's light colour values are stored
local light = {}
---A unique key under which a theme's dark colour values are stored
local dark = {}

---@class Theme an interface for accessing colour values
---@field add_variant function a method for adding variants of the `Theme`
local Theme = {}

Theme.prototype = {
    ---A method for adding variants of the `Theme`
    ---@param self Theme the theme itself
    ---@param variant "'light'"|"'dark'" the name of the variant
    ---@param colour_map table<string, string> a map of colour names to values
    add_variant = function (self, variant, colour_map)
       rawset(self, variant, colour_map)
    end
}

Theme.mt = {
	---The index metamethod of a Theme
	---@param self Theme a table containing theme variants
	---@param key string a colour name or `add_variant`
	---@return string|function the value associated with the provided key or index
    __index = function (self, key)
        if Theme.prototype[key] ~= nil then
           return Theme.prototype[key]
        end

        local theme_key = vim.api.nvim_get_option('background') == 'dark' and dark or light
        local theme = rawget(self, theme_key)
        return rawget(theme, key)
    end
}

---The Theme constructor
---@return Theme a new Theme
Theme.new = function ()
    local new = {}
    setmetatable(new, Theme.mt)
    return new
end

local theme = Theme:new()

theme:add_variant('light', {
    foreground = colours.lightBlack.hex,
    background = colours.lightWhite.hex,
    foreground_alt = colours.black.hex,
    background_alt = colours.white.hex,
    grey = colours.grey.hex,
    grey_alt = colours.lightGrey.hex,
    orange = colours.orange.hex,
    orange_alt = colours.lightOrange.hex,
	white = colours.white.hex,
	white_alt = colours.lightWhite.hex,
	black = colours.light.hex,
	black_alt = colours.lightBlack.hex,
	red = colours.red.hex,
	red_alt = colours.lightRed.hex,
	yellow = colours.yellow.hex,
	yellow_alt = colours.lightYellow.hex,
	green = colours.green.hex,
	green_alt = colours.lightGreen.hex,
	cyan = colours.cyan.hex,
	cyan_alt = colours.lightCyan.hex,
	blue = colours.blue.hex,
	blue_alt = colours.lightBlue.hex,
	magenta = colours.purple.hex,
	magenta = colours.lightPurple.hex,
})

theme:add_variant('dark', {
    foreground_bright = colours.lightWhite.hex,
    background_bright = colours.lightBlack.hex,
    foreground = colours.white.hex,
    background = colours.black.hex,
    foreground_dim = colours.lightGrey.hex,
    background_dim = colours.grey.hex,
})

M.Theme = Theme

return M
