local YamlTable = require('lxs.plugin_settings.shipwright').YamlTable
local colourscheme = require(vim.g.colors_name .. '.colours')

local function kitty(colours)
	local template = {
		['#> Vim Filetype'] = { comment_chars = '#', copy = 'vim:ft=kitty' },
		['#> Template Info'] = {
			comment_chars = '#:',
			copy = [[
                This is a template that can be used to create new kitty themes.
                Theme files should start with a metadata block consisting of
                lines beginning with ##. All metadata fields are optional.
            ]],
		},
		['#> Meta Name'] = {
			comment_chars = '##',
			copy = 'name: ' .. vim.g.colors_name,
		},
		['#> Meta Author'] = {
			comment_chars = '##',
			copy = 'author: Luke Xavier Symington',
		},
		['#> Meta License'] = {
			comment_chars = '##',
			copy = 'license: MIT',
		},
		['#> Meta Upstream'] = {
			comment_chars = '##',
			copy = 'upstream: https://github.com/lxsymington/dotfiles',
		},
		['#> Meta Blurb'] = {
			comment_chars = '##',
			copy = 'blurb: Personal theme',
		},
		['#> Settings Info'] = {
			comment_chars = '#:',
			copy = [[
                All the settings below are colors, which you can choose to modify, or use the
                defaults. You can also add non-color based settings if needed but note that
                these will not work with using kitty @ set-colors with this theme. For a
                reference on what these settings do see https://sw.kovidgoyal.net/kitty/conf/
            ]],
		},
		['#> Basic'] = {
			comment_chars = '#:',
			copy = 'The basic colors',
		},
		foreground = colours.white.hex,
		background = colours.black.hex,
		selection_foreground = 'none',
		selection_background = 'none',
		['#> Cursor'] = {
			comment_chars = '#:',
			copy = 'Cursor colours',
		},
		cursor = 'none',
		cursor_text_color = 'none',
		['#> URL'] = {
			comment_chars = '#:',
			copy = 'URL underline color when hovering with mouse',
		},
		url_color = colours.orange,
		['#> Border & Terminal Bell'] = {
			comment_chars = '#:',
			copy = 'kitty window border colors and terminal bell colors',
		},
		active_border_color = colours.green.hex,
		inactive_border_color = colours.lightGrey.hex,
		bell_border_color = colours.lightOrange.hex,
		visual_bell_color = 'none',
		['#> Titlebars'] = {
			comment_chars = '#:',
			copy = 'OS Window titlebar colors',
		},
		wayland_titlebar_color = 'system',
		macos_titlebar_color = 'system',
		['#> Tab Bars'] = {
			comment_chars = '#:',
			copy = 'Tab bar colors',
		},
		active_tab_foreground = colours.black.hex,
		active_tab_background = colours.white.hex,
		inactive_tab_foreground = colours.grey.hex,
		inactive_tab_background = colours.lightGrey.hex,
		tab_bar_background = 'none',
		tab_bar_margin_color = 'none',
		['#> Marks'] = {
			comment_chars = '#:',
			copy = 'Colours for marks (marked text in the terminal)',
		},
		mark1_foreground = colours.black.hex,
		mark1_background = colours.orange.hex,
		mark2_foreground = colours.black.hex,
		mark2_background = colours.lightOrange.hex,
		mark3_foreground = colours.black.hex,
		mark3_background = colours.lightGrey.hex,
		['#> Standard'] = {
			comment_chars = '#:',
			copy = 'The basic 16 colours',
		},
		['#> Black'] = {
			comment_chars = '#:',
			copy = 'Black',
		},
		color8 = colours.black.hex,
		color0 = colours.lightBlack.hex,
		['#> Red'] = {
			comment_chars = '#:',
			copy = 'Red',
		},
		color1 = colours.red.hex,
		color9 = colours.lightRed.hex,
		['#> Green'] = {
			comment_chars = '#:',
			copy = 'Green',
		},
		color2 = colours.green.hex,
		color10 = colours.lightGreen.hex,
		['#> Yellow'] = {
			comment_chars = '#:',
			copy = 'Yellow',
		},
		color3 = colours.yellow.hex,
		color11 = colours.lightYellow.hex,
		['#> Blue'] = {
			comment_chars = '#:',
			copy = 'Blue',
		},
		color4 = colours.blue.hex,
		color12 = colours.lightBlue.hex,
		['#> Purple'] = {
			comment_chars = '#:',
			copy = 'Purple',
		},
		color5 = colours.purple.hex,
		color13 = colours.lightPurple.hex,
		['#> Cyan'] = {
			comment_chars = '#:',
			copy = 'Cyan',
		},
		color6 = colours.cyan.hex,
		color14 = colours.lightCyan.hex,
		['#> White'] = {
			comment_chars = '#:',
			copy = 'White',
		},
		color7 = colours.white.hex,
		color15 = colours.lightWhite.hex,
	}

	local yamlTemplate = YamlTable.new(template)

	return yamlTemplate:tolines()
end

run(colourscheme, kitty, {
	overwrite,
	os.getenv('HOME') .. '/.dotfiles/kitty/themes/' .. vim.g.colors_name .. '.conf',
})
