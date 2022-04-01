local YamlTable = require('lxs.utils').YamlTable
local Theme = require('lxs.utils').Theme
local colours = require(vim.g.colors_name .. '.colours')

local theme_colours = Theme:new(colours)

local function kitty(theme)
	local template = YamlTable:new({
		characters = 80,
		comment_prefix = '#>',
		indent_char = ' ',
		indent_size = 2,
		separator = '',
	})
	template:add('#> Vim Filetype', { comment_chars = '#', copy = 'vim:ft=kitty' })
	template:add('#> Template Info', {
		comment_chars = '#:',
		copy = [[
            This is a template that can be used to create new kitty themes.
            Theme files should start with a metadata block consisting of
            lines beginning with ##. All metadata fields are optional.
        ]],
	})
	template:add('#> Meta Name', {
		comment_chars = '##',
		copy = 'name: ' .. vim.g.colors_name,
	})

	template:add('#> Meta Author', {
		comment_chars = '##',
		copy = 'author: Luke Xavier Symington',
	})
	template:add('#> Meta License', {
		comment_chars = '##',
		copy = 'license: MIT',
	})
	template:add('#> Meta Upstream', {
		comment_chars = '##',
		copy = 'upstream: https://github.com/lxsymington/dotfiles',
	})
	template:add('#> Meta Blurb', {
		comment_chars = '##',
		copy = 'blurb: Personal theme',
	})
	template:add('#> Settings Info', {
		comment_chars = '#:',
		copy = [[
            All the settings below are colors, which you can choose to modify, or use the
            defaults. You can also add non-color based settings if needed but note that
            these will not work with using kitty @ set-colors with this theme. For a
            reference on what these settings do see https://sw.kovidgoyal.net/kitty/conf/
        ]],
	})
	template:add('#> Basic', {
		comment_chars = '#:',
		copy = 'The basic colors',
	})
	template:add('foreground', theme.foreground)
	template:add('background', theme.background)
	template:add('selection_foreground', 'none')
	template:add('selection_background', 'none')
	template:add('#> Cursor', {
		comment_chars = '#:',
		copy = 'Cursor colours',
	})
	template:add('cursor', theme.orange)
	template:add('cursor_text_color', theme.white_alt)
	template:add('#> URL', {
		comment_chars = '#:',
		copy = 'URL underline color when hovering with mouse',
	})
	template:add('url_color', theme.orange)
	template:add('#> Border & Terminal Bell', {
		comment_chars = '#:',
		copy = 'kitty window border colors and terminal bell colors',
	})
	template:add('active_border_color', theme.green)
	template:add('inactive_border_color', theme.grey_alt)
	template:add('bell_border_color', theme.orange_alt)
	template:add('visual_bell_color', 'none')
	template:add('#> Titlebars', {
		comment_chars = '#:',
		copy = 'OS Window titlebar colors',
	})
	template:add('wayland_titlebar_color', 'system')
	template:add('macos_titlebar_color', 'system')
	template:add('#> Tab Bars', {
		comment_chars = '#:',
		copy = 'Tab bar colors',
	})
	template:add('active_tab_foreground', theme.black)
	template:add('active_tab_background', theme.white)
	template:add('inactive_tab_foreground', theme.grey)
	template:add('inactive_tab_background', theme.grey_alt)
	template:add('tab_bar_background', 'none')
	template:add('tab_bar_margin_color', 'none')
	template:add('#> Marks', {
		comment_chars = '#:',
		copy = 'Colours for marks (marked text in the terminal)',
	})
	template:add('mark1_foreground', theme.black)
	template:add('mark1_background', theme.orange)
	template:add('mark2_foreground', theme.black)
	template:add('mark2_background', theme.orange_alt)
	template:add('mark3_foreground', theme.black)
	template:add('mark3_background', theme.grey_alt)
	template:add('#> Standard', {
		comment_chars = '#:',
		copy = 'The basic 16 colours',
	})
	template:add('#> Black', {
		comment_chars = '#:',
		copy = 'Black',
	})
	template:add('color8', theme.black)
	template:add('color0', theme.black_alt)
	template:add('#> Red', {
		comment_chars = '#:',
		copy = 'Red',
	})
	template:add('color1', theme.red)
	template:add('color9', theme.red_alt)
	template:add('#> Green', {
		comment_chars = '#:',
		copy = 'Green',
	})
	template:add('color2', theme.green)
	template:add('color10', theme.green_alt)
	template:add('#> Yellow', {
		comment_chars = '#:',
		copy = 'Yellow',
	})
	template:add('color3', theme.yellow)
	template:add('color11', theme.yellow_alt)
	template:add('#> Blue', {
		comment_chars = '#:',
		copy = 'Blue',
	})
	template:add('color4', theme.blue)
	template:add('color12', theme.blue_alt)
	template:add('#> Purple', {
		comment_chars = '#:',
		copy = 'Purple',
	})
	template:add('color5', theme.purple)
	template:add('color13', theme.purple_alt)
	template:add('#> Cyan', {
		comment_chars = '#:',
		copy = 'Cyan',
	})
	template:add('color6', theme.cyan)
	template:add('color14', theme.cyan_alt)
	template:add('#> White', {
		comment_chars = '#:',
		copy = 'White',
	})
	template:add('color7', theme.white)
	template:add('color15', theme.white_alt)

	return template:tolines()
end

run(kitty(theme_colours), {
	overwrite,
	os.getenv('HOME') .. '/.dotfiles/kitty/themes/' .. vim.g.colors_name .. '.conf',
})
