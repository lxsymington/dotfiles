local YamlTable = require('lxs.utils').YamlTable

local function alacritty(theme)
    local config = {
		characters = 80,
		comment_prefix = '#>',
		indent_char = ' ',
		indent_size = 2,
		separator = ':',
		quoted_values = true,
	}
    local primary = YamlTable:new(config)
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
    search_matches:add('foreground', theme.background)
	search_matches:add('background', theme.green)

    local search_focused_match = YamlTable:new(config)
    search_focused_match:add('foreground', 'CellBackground')
	search_focused_match:add('background', 'CellForeground')

    local search_bar = YamlTable:new(config)
    search_bar:add('foreground', theme.foreground_alt)
	search_bar:add('background', theme.background_alt)

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
    hints_start:add('foreground', theme.foreground_alt)
    hints_start:add('background', theme.orange_alt)

    local hints_end = YamlTable:new(config)
    hints_end:add('foreground', theme.orange_alt)
    hints_end:add('background', theme.foreground_alt)

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
	line_indicator:add('background', theme.grey)

	local normal = YamlTable:new(config)
	normal:add('white', theme.white)
	normal:add('black', theme.black_alt)
	normal:add('red', theme.red)
	normal:add('yellow', theme.yellow)
	normal:add('green', theme.green)
	normal:add('cyan', theme.cyan)
	normal:add('blue', theme.blue)
	normal:add('magenta', theme.magenta)

	local bright = YamlTable:new(config)
	bright:add('white', theme.white_alt)
	bright:add('black', theme.grey)
	bright:add('red', theme.red_alt)
	bright:add('yellow', theme.yellow_alt)
	bright:add('green', theme.green_alt)
	bright:add('cyan', theme.cyan_alt)
	bright:add('blue', theme.blue_alt)
	bright:add('magenta', theme.magenta_alt)

	local dim =  YamlTable:new(config)
	dim:add('white', theme.white_common)
	dim:add('black', theme.black_common)
	dim:add('red', theme.red_common)
	dim:add('yellow', theme.yellow_common)
	dim:add('green', theme.green_common)
	dim:add('cyan', theme.cyan_common)
	dim:add('blue', theme.blue_common)
	dim:add('magenta', theme.magenta_common)

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

	local template = YamlTable:new(config)
	template:add('colors', colors)

	return template:tolines()
end

return alacritty
