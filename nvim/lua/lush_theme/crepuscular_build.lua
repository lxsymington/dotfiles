local uv = vim.loop
local api = vim.api
local lush = require('lush')

local targets = {}
local M = {}

local YamlTable = {
	__tostring = function(table)
		local yaml = ''
		local indent_level = 0

		local function yamlRecurse(tableSection, indent_level)
			local result = ''

			for key, value in pairs(tableSection, indent_level) do
				-- TODO: handle list-like tables
				if type(value) == 'table' then
					result = string.format(
						'%s\n%s%s:%s',
						result,
						string.rep(' ', 2 * indent_level),
						key,
						yamlRecurse(value, indent_level + 1)
					)
				else
					result = string.format(
						'%s\n%s%s: %q',
						result,
						string.rep(' ', 2 * indent_level),
						key,
						value
					)
				end
			end

			return result
		end

		return yamlRecurse(table, indent_level)
	end,
}

function targets.alacritty(colours)
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

	setmetatable(template, YamlTable)

	return string.format('%s', template)
end

local function write_file(file, buf)
	local fd = assert(uv.fs_open(file, 'w', 420))
	uv.fs_write(fd, buf, -1)
	assert(uv.fs_close(fd))
end

function M.setup()
	function CrepuscularBuild()
		local crepuscular

		for _, variant in ipairs({ 'dark', 'light' }) do
			package.loaded['lush_theme.crepuscular_colours'] = nil
			vim.opt.background = variant
			crepuscular = require('lush_theme.crepuscular_colours')

			write_file(
				string.format(
					os.getenv('HOME') .. '/.dotfiles/alacritty/.alacritty.colours.%s.yml',
					variant
				),
				targets.alacritty(crepuscular)
			)
		end
	end

	api.nvim_command([[ command! CrepuscularBuild lua CrepuscularBuild() ]])

	api.nvim_exec(
		[[
        augroup LushBuild
        autocmd!
        autocmd BufWritePost crepuscular_build.lua CrepuscularBuild
        augroup end
        ]],
		false
	)

	lush(require('lush_theme.' .. vim.g.colors_name))
end

return M
