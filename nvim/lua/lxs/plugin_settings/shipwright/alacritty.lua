local YamlTable = require('lxs.plugin_settings.shipwright.utils').YamlTable
local theme = require('lxs.plugin_settings.shipwright.theme').current

local function alacritty(colours)
    local primary = YamlTable:new()
    primary:add('foreground', theme.foreground)
	primary:add('background', theme.background)
	primary:add('#> Foreground', {
        comment_chars = '#',
        copy = [[
            Bright and dim foreground colors

            The dimmed foreground color is calculated automatically if it is not
            present. If the bright foreground color is not set, or
            `draw_bold_text_with_bright_colors` is `false`, the normal foreground
            color will be used.
        ]],
    })
    primary:add('dim_foreground', theme.grey)
	primary:add('bright_foreground', theme.foreground_alt)

    local cursor = YamlTable:new()
    cursor:add('text', 'CellBackground')
	cursor:add('cursor', 'CellForeground')

    local vi_mode_cursor = YamlTable:new()
    vi_mode_cursor:add('text', 'CellBackground')
	vi_mode_cursor:add('cursor', 'CellForeground')

    local selection = YamlTable:new()
    selection:add('text', 'CellBackground')
	selection:add('background', 'CellForeground')

    local search_matches = YamlTable:new()
    search_matches:add('foreground', theme.background)
	search_matches:add('background', theme.green)

    local search_focused_match = YamlTable:new()
    search_focused_match:add('foreground', 'CellBackground')
	search_focused_match:add('background', 'CellForeground')

    local search_bar = YamlTable:new()
    search_bar:add('foreground', theme.foreground_alt)
	search_bar:add('background', theme.background_alt)

    local search = YamlTable:new()
    search:add('#> CellForeground', {
        comment_chars = '#',
        copy = [[
            Allowed values are CellForeground and CellBackground, which reference the
            affected cell, or hexadecimal colors like #ff00ff.
        ]],
    })
    search:add('matches', search_matches)
    search:add('focused_match', search_focused_match)
    search:add('bar', search_bar)

    local hints_start = YamlTable:new()
    hints_start:add('foreground', theme.foreground_alt)
    hints_start:add('background', theme.orange_alt)

    local hints_end = YamlTable:new()
    hints_end:add('foreground', theme.orange_alt)
    hints_end:add('background', theme.foreground_alt)

	local hints = YamlTable:new()
    hints:add('#> Hint Head', {
        comment_chars = '#',
        copy = [[
            First character in the hint label

            Allowed values are CellForeground/CellBackground, which reference the
            affected cell, or hexadecimal colors like #ff00ff.
        ]],
    })
    hints:add('start', hints_start)
    hints:add('#> Hint Tail', {
        comment_chars = '#',
        copy = [[
            All characters after the first one in the hint label

            Allowed values are CellForeground/CellBackground, which reference the
            affected cell, or hexadecimal colors like #ff00ff.
        ]],
    })
    hints:add('end', hints_end)

	local line_indicator = YamlTable:new()
	line_indicator:add('foreground', 'None')
	line_indicator:add('background', theme.grey)

	local normal = YamlTable:new()
	normal:add('white', theme.white)
	normal:add('black', theme.black_alt)
	normal:add('red', theme.red)
	normal:add('yellow', theme.yellow)
	normal:add('green', theme.green)
	normal:add('cyan', theme.cyan)
	normal:add('blue', theme.blue)
	normal:add('magenta', theme.magenta)

	local bright = YamlTable:new()
	bright:add('white', theme.white_alt)
	bright:add('black', theme.grey)
	bright:add('red', theme.red_alt)
	bright:add('yellow', theme.yellow_alt)
	bright:add('green', theme.green_alt)
	bright:add('cyan', theme.cyan_alt)
	bright:add('blue', theme.blue_alt)
	bright:add('magenta', theme.magenta_alt)

	local dim =  YamlTable:new()
	dim:add('white', colours.white.abs_darken(5).hex)
	dim:add('black', colours.black.abs_lighten(15).hex)
	dim:add('red', colours.red.abs_lighten(15).abs_desaturate(30).hex)
	dim:add('yellow', colours.yellow.abs_darken(15).abs_desaturate(30).hex)
	dim:add('green', colours.green.abs_lighten(30).abs_desaturate(15).hex)
	dim:add('cyan', colours.cyan.abs_darken(15).abs_desaturate(15).hex)
	dim:add('blue', colours.blue.abs_desaturate(45).hex)
	dim:add('magenta', colours.purple.abs_darken(15).abs_desaturate(30).hex)

	local colors = YamlTable:new()
	colors:add('primary', primary)
	colors:add('#> Cursor', {
        comment_chars = '#',
        copy = [[
            Cursor colors

            Colors which should be used to draw the terminal cursor.

            Allowed values are CellForeground and CellBackground, which reference the
            affected cell, or hexadecimal colors like #ff00ff.
        ]],
    })
    colors:add('cursor', cursor)
    colors:add('#> Vi Mode', {
        comment_chars = '#',
        copy = [[
            Vi mode cursor colors

            Colors for the cursor when the vi mode is active.

            Allowed values are CellForeground and CellBackground, which reference the
            affected cell, or hexadecimal colors like #ff00ff.
        ]],
    })
    colors:add('vi_mode_cursor', vi_mode_cursor)
    colors:add('#> Selection', {
        comment_chars = '#',
        copy = [[
            Selection colors

            Colors which should be used to draw the selection area.

            Allowed values are CellForeground and CellBackground, which reference the
            affected cell, or hexadecimal colors like #ff00ff.
        ]],
    })
    colors:add('selection', selection)
    colors:add('#> Search', {
        comment_chars = '#',
        copy = [[
            Search colors

            Colors used for the search bar and match highlighting.
        ]],
    })
    colors:add('search', search)
	colors:add('#> Hints', { comment_chars ='#', copy = 'Keyboard regex hints' })
    colors:add('hints', hints)
    colors:add('#> Line Indicator', {
        comment_chars = '#',
        copy = [[
            Line indicator

            Color used for the indicator displaying the position in history during
            search and vi mode.

            By default, these will use the opposing primary color.
        ]],
    })
    colors:add('line_indicator', line_indicator)
    colors:add('#> Normal', { comment_chars = '#', copy = 'Normal colours' })
    colors:add('normal', normal)
    colors:add('#> Bright', { comment_chars = '#', copy = 'Bright colours' })
    colors:add('bright', bright)
    colors:add('#> Dim', {
        comment_chars = '#',
        copy = [[
            Dim colors

            If the dim colors are not set, they will be calculated automatically based
            on the `normal` colors.
        ]],
    })
    colors:add('dim', dim)

	local template = YamlTable:new()
	template:add('colors', colors)

	return template:tolines()
end

run(colourscheme, alacritty, {
	overwrite,
	os.getenv('HOME') .. '/.config/alacritty/alacritty.colours.yml',
})
