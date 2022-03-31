local colours = require(vim.g.colors_name .. '.colours')
local M = {}

---A unique key under which a theme's light colour values are stored
local light = {}
---A unique key under which a theme's dark colour values are stored
local dark = {}

---@class Theme an interface for accessing colour values
---@field add_variant function a method for adding variants of the `Theme`
---@field public foreground string
---@field public background string
---@field public foreground_alt string
---@field public background_alt string
---@field public grey string
---@field public grey_alt string
---@field public orange string
---@field public orange_alt string
---@field public white string
---@field public white_alt string
---@field public black string
---@field public black_alt string
---@field public red string
---@field public red_alt string
---@field public yellow string
---@field public yellow_alt string
---@field public green string
---@field public green_alt string
---@field public cyan string
---@field public cyan_alt string
---@field public blue string
---@field public blue_alt string
---@field public magenta string
---@field public magenta_alt string
local Theme = {}

Theme.prototype = {
    ---A method for adding variants of the `Theme`
    ---@param self Theme the theme itself
    ---@param variant "'light'"|"'dark'" the name of the variant
    ---@param colour_map table<string, string> a map of colour names to values
    add_variant = function (self, variant, colour_map)
       local theme_key = variant == 'dark' and dark or light
       rawset(self, theme_key, colour_map)
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

M.Theme = Theme

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
	magenta_alt = colours.lightPurple.hex,
})

theme:add_variant('dark', {
    foreground = colours.white.hex,
    background = colours.black.hex,
    foreground_alt = colours.lightWhite.hex,
    background_alt = colours.lightBlack.hex,
    grey = colours.lightGrey.hex,
    grey_alt = colours.grey.hex,
    orange = colours.lightOrange.hex,
    orange_alt = colours.orange.hex,
	white = colours.lightWhite.hex,
	white_alt = colours.white.hex,
	black = colours.lightBlack.hex,
	black_alt = colours.light.hex,
	red = colours.lightRed.hex,
	red_alt = colours.red.hex,
	yellow = colours.lightYellow.hex,
	yellow_alt = colours.yellow.hex,
	green = colours.lightGreen.hex,
	green_alt = colours.green.hex,
	cyan = colours.lightCyan.hex,
	cyan_alt = colours.cyan.hex,
	blue = colours.lightBlue.hex,
	blue_alt = colours.blue.hex,
	magenta = colours.lightPurple.hex,
	magenta_alt = colours.purple.hex,
})

M.current = theme

return M
