local YamlTable = require('lxs.plugin_settings.shipwright').YamlTable
local OrderedTable = require('lxs.plugin_settings.shipwright.utils').OrderedTable
local colourscheme = require(vim.g.colors_name .. '.colours')

local function kitty(colours)
    local template = OrderedTable:new()
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
    template:add('foreground', colours.white.hex)
    template:add('background', colours.black.hex)
    template:add('selection_foreground', 'none')
    template:add('selection_background', 'none')
    template:add('#> Cursor', {
        comment_chars = '#:',
        copy = 'Cursor colours',
    })
    template:add('cursor', 'none')
    template:add('cursor_text_color', 'none')
    template:add('#> URL', {
        comment_chars = '#:',
        copy = 'URL underline color when hovering with mouse',
    })
    template:add('url_color', colours.orange)
    template:add('#> Border & Terminal Bell', {
        comment_chars = '#:',
        copy = 'kitty window border colors and terminal bell colors',
    })
    template:add('active_border_color', colours.green.hex)
    template:add('inactive_border_color', colours.lightGrey.hex)
    template:add('bell_border_color', colours.lightOrange.hex)
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
    template:add('active_tab_foreground', colours.black.hex)
    template:add('active_tab_background', colours.white.hex)
    template:add('inactive_tab_foreground', colours.grey.hex)
    template:add('inactive_tab_background', colours.lightGrey.hex)
    template:add('tab_bar_background', 'none')
    template:add('tab_bar_margin_color', 'none')
    template:add('#> Marks', {
        comment_chars = '#:',
        copy = 'Colours for marks (marked text in the terminal)',
    })
    template:add('mark1_foreground', colours.black.hex)
    template:add('mark1_background', colours.orange.hex)
    template:add('mark2_foreground', colours.black.hex)
    template:add('mark2_background', colours.lightOrange.hex)
    template:add('mark3_foreground', colours.black.hex)
    template:add('mark3_background', colours.lightGrey.hex)
    template:add('#> Standard', {
        comment_chars = '#:',
        copy = 'The basic 16 colours',
    })
    template:add('#> Black', {
        comment_chars = '#:',
        copy = 'Black',
    })
    template:add('color8', colours.black.hex)
    template:add('color0', colours.lightBlack.hex)
    template:add('#> Red', {
        comment_chars = '#:',
        copy = 'Red',
    })
    template:add('color1', colours.red.hex)
    template:add('color9', colours.lightRed.hex)
    template:add('#> Green', {
        comment_chars = '#:',
        copy = 'Green',
    })
    template:add('color2', colours.green.hex)
    template:add('color10', colours.lightGreen.hex)
    template:add('#> Yellow', {
        comment_chars = '#:',
        copy = 'Yellow',
    })
    template:add('color3', colours.yellow.hex)
    template:add('color11', colours.lightYellow.hex)
    template:add('#> Blue', {
        comment_chars = '#:',
        copy = 'Blue',
    })
    template:add('color4', colours.blue.hex)
    template:add('color12', colours.lightBlue.hex)
    template:add('#> Purple', {
        comment_chars = '#:',
        copy = 'Purple',
    })
    template:add('color5', colours.purple.hex)
    template:add('color13', colours.lightPurple.hex)
    template:add('#> Cyan', {
        comment_chars = '#:',
        copy = 'Cyan',
    })
    template:add('color6', colours.cyan.hex)
    template:add('color14', colours.lightCyan.hex)
    template:add('#> White', {
        comment_chars = '#:',
        copy = 'White',
    })
    template:add('color7', colours.white.hex)
    template:add('color15', colours.lightWhite.hex)

    P(template)

    local yamlTemplate = YamlTable.new(template)

    return yamlTemplate:tolines()
end

run(colourscheme, kitty, {
    overwrite,
    os.getenv('HOME') .. '/.dotfiles/kitty/themes/' .. vim.g.colors_name .. '.conf',
})
