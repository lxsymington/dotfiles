---A unique key under which the source colours are stored
local source = {}
---A unique key under which the variant keys are stored
local variants = {}
---A unique key under which a theme's light colour values are stored
local light = {}
---A unique key under which a theme's dark colour values are stored
local dark = {}
---A unique key under which a theme's common colour values are stored
local common = {}

---@class Theme an interface for accessing colour values
---@field public add_variant function a method for adding variants of the `Theme`
---@field public foreground string
---@field public foreground_alt string
---@field public background string
---@field public background_alt string
---@field public grey string
---@field public grey_alt string
---@field public grey_common string
---@field public orange string
---@field public orange_alt string
---@field public orange_common string
---@field public white string
---@field public white_alt string
---@field public white_common string
---@field public black string
---@field public black_alt string
---@field public black_common string
---@field public red string
---@field public red_alt string
---@field public red_common string
---@field public yellow string
---@field public yellow_alt string
---@field public yellow_common string
---@field public green string
---@field public green_alt string
---@field public green_common string
---@field public cyan string
---@field public cyan_alt string
---@field public cyan_common string
---@field public blue string
---@field public blue_alt string
---@field public blue_common string
---@field public magenta string
---@field public magenta_alt string
---@field public magenta_common string
local Theme = {}

Theme.prototype = {
    ---A method for adding variants of the `Theme`
    ---@param self Theme the theme itself
    ---@param variant "'light'"|"'dark'"|"'common'" the name of the variant
    ---@param colour_map table<string, string> a map of colour names to values
    add_variant = function (self, variant, colour_map)
        local variant_map = rawget(self, variants)
        rawset(self, variant_map[variant], colour_map)
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

        local variant_map = rawget(self, variants)

        local variant = key:match('common$') and 'common' or vim.api.nvim_get_option('background')
        local theme_key = rawget(variant_map, variant)
        local theme = rawget(self, theme_key)
        local colour_value = rawget(theme, key)
        print(key .. ": " .. colour_value)
        return colour_value
    end
}

---The Theme constructor
---@param colours table<string, table> the colours the theme variants will reference
---@return Theme a new Theme
Theme.new = function (_, colours)
    local new = {}
    new[variants] = {
        dark = dark,
        light = light,
        common = common,
    }
    new[source] = colours
    new[light] = {
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
        black = colours.black.hex,
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
    }
    new[dark] = {
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
        black_alt = colours.black.hex,
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
    }
    new[common] = {
        white_common = colours.white.abs_darken(5).hex,
        black_common = colours.black.abs_lighten(15).hex,
        red_common = colours.red.abs_lighten(15).abs_desaturate(30).hex,
        yellow_common = colours.yellow.abs_darken(15).abs_desaturate(30).hex,
        green_common = colours.green.abs_lighten(30).abs_desaturate(15).hex,
        cyan_common = colours.cyan.abs_darken(15).abs_desaturate(15).hex,
        blue_common = colours.blue.abs_desaturate(45).hex,
        magenta_common = colours.purple.abs_darken(15).abs_desaturate(30).hex,
    }
    setmetatable(new, Theme.mt)
    return new
end

return Theme
