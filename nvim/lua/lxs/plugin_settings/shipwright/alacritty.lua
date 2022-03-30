local YamlTable = require('lxs.plugin_settings.shipwright.utils').YamlTable
local colourscheme = require(vim.g.colors_name .. '.colours')

local function alacritty(colours)
	local config = {
		characters = 80,
		comment_prefix = '#>',
		indent_char = ' ',
		indent_size = 2,
		separator = ':',
	}
	local primary = YamlTable:new(config)
	primary:add('foreground', colours.white.hex)
	primary:add('background', colours.black.hex)
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
	primary:add('dim_foreground', colours.lightGrey.hex)
	primary:add('bright_foreground', colours.lightWhite.hex)

	local cursor = YamlTable:new(config)
	cursor:add('text', 'CellBackground')
	cursor:add('cursor', 'CellForeground')

	local vi_mode_cursor = YamlTable:new(config)
	vi_mode_cursor:add('text', 'CellBackground')
	vi_mode_cursor:add('cursor', 'CellForeground')

	local selection = YamlTable:new(config)
	selection:add('text', 'CellBackground')
	selection:add('background', 'CellForeground')

	local search_matches = YamlTable:new(config)
	search_matches:add('foreground', '#000000')
	search_matches:add('background', '#ffffff')

	local search_focused_match = YamlTable:new(config)
	search_focused_match:add('foreground', 'CellBackground')
	search_focused_match:add('background', 'CellForeground')

	local search_bar = YamlTable:new(config)
	search_bar:add('foreground', '#1a141f')
	search_bar:add('background', '#ebccad')

	local search = YamlTable:new(config)
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

	local hints_start = YamlTable:new(config)
	hints_start:add('foreground', '#1d1f21')
	hints_start:add('background', '#e9ff5e')

	local hints_end = YamlTable:new(config)
	hints_end:add('foreground', '#e9ff5e')
	hints_end:add('background', '#1d1f21')

	local hints = YamlTable:new(config)
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

	local line_indicator = YamlTable:new(config)
	line_indicator:add('foreground', 'None')
	line_indicator:add('background', colours.grey.hex)

	local normal = YamlTable:new(config)
	normal:add('white', colours.white.hex)
	normal:add('black', colours.lightBlack.hex)
	normal:add('red', colours.red.hex)
	normal:add('yellow', colours.yellow.hex)
	normal:add('green', colours.green.hex)
	normal:add('cyan', colours.cyan.hex)
	normal:add('blue', colours.blue.hex)
	normal:add('magenta', colours.purple.hex)

	local bright = YamlTable:new(config)
	bright:add('white', colours.lightWhite.hex)
	bright:add('black', colours.grey.hex)
	bright:add('red', colours.lightRed.hex)
	bright:add('yellow', colours.lightYellow.hex)
	bright:add('green', colours.lightGreen.hex)
	bright:add('cyan', colours.lightCyan.hex)
	bright:add('blue', colours.lightBlue.hex)
	bright:add('magenta', colours.lightPurple.hex)

	local dim = YamlTable:new(config)
	dim:add('white', colours.white.abs_darken(5).hex)
	dim:add('black', colours.black.abs_lighten(15).hex)
	dim:add('red', colours.red.abs_lighten(15).abs_desaturate(30).hex)
	dim:add('yellow', colours.yellow.abs_darken(15).abs_desaturate(30).hex)
	dim:add('green', colours.green.abs_lighten(30).abs_desaturate(15).hex)
	dim:add('cyan', colours.cyan.abs_darken(15).abs_desaturate(15).hex)
	dim:add('blue', colours.blue.abs_desaturate(45).hex)
	dim:add('magenta', colours.purple.abs_darken(15).abs_desaturate(30).hex)

	local colors = YamlTable:new(config)
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
	colors:add('#> Hints', { comment_chars = '#', copy = 'Keyboard regex hints' })
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

	local template = YamlTable:new(config)
	template:add('colors', colors)

	return template:tolines()
end

run(colourscheme, alacritty, {
	overwrite,
	os.getenv('HOME') .. '/.config/alacritty/alacritty.colours.yml',
})
