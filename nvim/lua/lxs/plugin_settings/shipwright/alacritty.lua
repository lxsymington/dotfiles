local YamlTable = require('lxs.plugin_settings.shipwright').YamlTable
local colourscheme = require(vim.g.colors_name .. '.colours')

local function alacritty(colours)
    local template = {
        colors = {
            primary = {
                foreground = colours.white.hex,
                background = colours.black.hex,
                --[[
                    Bright and dim foreground colors

                    The dimmed foreground color is calculated automatically if it is not
                    present. If the bright foreground color is not set, or
                    `draw_bold_text_with_bright_colors` is `false`, the normal foreground
                    color will be used.
                ]]
                dim_foreground = colours.lightGrey.hex,
                bright_foreground = colours.lightWhite.hex,
            },
            --[[
                Cursor colors

                Colors which should be used to draw the terminal cursor.

                Allowed values are CellForeground and CellBackground, which reference the
                affected cell, or hexadecimal colors like #ff00ff.
            ]]
            cursor = {
                text = 'CellBackground',
                cursor = 'CellForeground',
            },
            --[[
                Vi mode cursor colors

                Colors for the cursor when the vi mode is active.

                Allowed values are CellForeground and CellBackground, which reference the
                affected cell, or hexadecimal colors like #ff00ff.
            ]]
            vi_mode_cursor = {
                text = 'CellBackground',
                cursor = 'CellForeground',
            },
            --[[
                Selection colors

                Colors which should be used to draw the selection area.

                Allowed values are CellForeground and CellBackground, which reference the
                affected cell, or hexadecimal colors like #ff00ff.
            ]]
            selection = {
                text = 'CellBackground',
                background = 'CellForeground',
            },
            --[[
                Search colors

                Colors used for the search bar and match highlighting.
            ]]
            search = {
                --[[
                    Allowed values are CellForeground and CellBackground, which reference the
                    affected cell, or hexadecimal colors like #ff00ff.
                ]]
                matches = {
                    foreground = '#000000',
                    background = '#ffffff',
                },
                focused_match = {
                    foreground = 'CellBackground',
                    background = 'CellForeground',
                },
                bar = {
                    background = '#ebccad',
                    foreground = '#1a141f',
                },
            },
            -- Keyboard regex hints
            hints = {
                --[[
                    First character in the hint label

                    Allowed values are CellForeground/CellBackground, which reference the
                    affected cell, or hexadecimal colors like #ff00ff.
                ]]
                start = {
                    foreground = '#1d1f21',
                    background = '#e9ff5e',
                },
                --[[
                    All characters after the first one in the hint label

                    Allowed values are CellForeground/CellBackground, which reference the
                    affected cell, or hexadecimal colors like #ff00ff.
                ]]
                ['end'] = {
                    foreground = '#e9ff5e',
                    background = '#1d1f21',
                },
            },
            --[[
                Line indicator

                Color used for the indicator displaying the position in history during
                search and vi mode.

                By default, these will use the opposing primary color.
            ]]
            line_indicator = {
                foreground = 'None',
                background = colours.grey.hex,
            },
            -- Normal colours
            normal = {
                white = colours.white.hex,
                black = colours.lightBlack.hex,
                red = colours.red.hex,
                yellow = colours.yellow.hex,
                green = colours.green.hex,
                cyan = colours.cyan.hex,
                blue = colours.blue.hex,
                magenta = colours.purple.hex,
            },
            -- Bright colours
            bright = {
                white = colours.lightWhite.hex,
                black = colours.grey.hex,
                red = colours.lightRed.hex,
                yellow = colours.lightYellow.hex,
                green = colours.lightGreen.hex,
                cyan = colours.lightCyan.hex,
                blue = colours.lightBlue.hex,
                magenta = colours.lightPurple.hex,
            },
            --[[
                Dim colors

                If the dim colors are not set, they will be calculated automatically based
                on the `normal` colors.
            ]]
            dim = {
                white = colours.white.abs_darken(5).hex,
                black = colours.black.abs_lighten(15).hex,
                red = colours.red.abs_lighten(15).abs_desaturate(30).hex,
                yellow = colours.yellow.abs_darken(15).abs_desaturate(30).hex,
                green = colours.green.abs_lighten(30).abs_desaturate(15).hex,
                cyan = colours.cyan.abs_darken(15).abs_desaturate(15).hex,
                blue = colours.blue.abs_desaturate(45).hex,
                magenta = colours.purple.abs_darken(15).abs_desaturate(30).hex,
            },
        },
    }

    local yamlTemplate = YamlTable.new(template)

    print('template')
    P(yamlTemplate)
    print('template to lines result')
    P(yamlTemplate:tolines())
    local lines = yamlTemplate:tolines()
    P(lines)

    print('return alacritty')
    return yamlTemplate:tolines()
end

run(colourscheme, alacritty, {
	overwrite,
	os.getenv('HOME') .. '/.config/alacritty/alacritty.colours.yml',
})
