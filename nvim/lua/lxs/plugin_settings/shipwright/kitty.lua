local YamlTable = require('lxs.plugin_settings.shipwright').YamlTable
local colourscheme = require(vim.g.colors_name .. '.colours')

local function kitty(colours)
	local template = {
        foreground = colours.white.hex,
        background = colours.black.hex,
        background_opacity = 0.85,
        background_image = 'none',
        background_image_layout = 'tiled',
        background_image_linear = 'no',
        dynamic_background_opacity = 'no',
        background_tint = 0.0,
        dim_opacity = 0.75,
        selection_foreground = 'none',
        selection_background = 'none',
        color8 = colours.black.hex,
        color0 = colours.lightBlack.hex,
        color1 = colours.red.hex,
        color9 = colours.lightRed.hex,
        color2 = colours.green.hex,
        color10 = colours.lightGreen.hex,
        color3 = colours.yellow.hex,
        color11 = colours.lightYellow.hex,
        color4 = colours.blue.hex,
        color12 = colours.lightBlue.hex,
        color5 = colours.purple.hex,
        color13 = colours.lightPurple.hex,
        color6 = colours.cyan.hex,
        color14 = colours.lightCyan.hex,
        color7 = colours.white.hex,
        color15 = colours.lightWhite.hex,
        mark1_foreground = colours.black.hex,
        mark1_background = colours.orange.hex,
        mark2_foreground = colours.black.hex,
        mark2_background = colours.lightOrange.hex,
        mark3_foreground = colours.black.hex,
        mark3_background = colours.lightGrey.hex,
	}

    local yamlTemplate = YamlTable.new(template)

    return yamlTemplate:tolines()
end

run(colourscheme, kitty, {
	overwrite,
	os.getenv('HOME') .. '/.dotfiles/kitty/themes/' .. vim.g.colors_name .. '.conf',
})
