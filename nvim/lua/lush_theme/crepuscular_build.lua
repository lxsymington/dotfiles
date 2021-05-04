local uv = vim.loop
local lush = require("lush")

local targets = {}
local M = {}

local YamlTable = {
	__tostring = function(table)
		local yaml = ""
		local indent_level = 0

		local function yamlRecurse(tableSection, indent_level)
			local result = ""

			for key, value in pairs(tableSection, indent_level) do
				-- TODO: handle list-like tables
				if type(value) == "table" then
					result = string.format(
						"%s\n%s%s:%s",
						result,
						string.rep(" ", 2 * indent_level),
						key,
						yamlRecurse(value, indent_level + 1)
					)
				else
					result = string.format("%s\n%s%s: %s", result, string.rep(" ", 2 * indent_level), key, value)
				end
			end

			return result
		end

		return yamlRecurse(table, indent_level)
	end,
}

function targets.alacritty(colours)
	local template = {
		primary = {
			foreground = colours.white.hex,
			background = colours.black.hex,
		},
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
	}

	setmetatable(template, YamlTable)

	return template
end

local function write_file(file, buf)
	local fd = assert(uv.fs_open(file, "w", 420))
	uv.fs_write(fd, buf, -1)
	assert(uv.fs_close(fd))
end

function M.build(t, dir)
    local crepuscular

    for _, variant in inpairs({ 'dark', 'light' }) do
        package.loaded['lush_theme.crepuscular_colours'] = nil
        vim.o.background = variant
        crepuscular = require('lush_theme.crepuscular_colours')

        write_file(string.format("~/.dotfiles/alacritty/alacritty_colours_%s.yml", variant), targets.alacritty(crepuscular))
    end
end

return M
