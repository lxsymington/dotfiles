local api = vim.api
local lush = require('lush')

local M = {}

local function format_prose(prose, characters, indent_level, comment_chars)
	local lines = {}
	local line = string.format('%s%s', string.rep(' ', 2 * indent_level), comment_chars)

	for word in string.gmatch(prose, '[^%s]+') do
		if string.len(line .. ' ' .. word) < characters then
			line = string.format('%s %s', line, word)
		else
			table.insert(lines, line)
			line = string.format('%s%s %s', string.rep(' ', 2 * indent_level), comment_chars, word)
		end
	end

	return lines
end

local function yaml_recurse(table_section, indent_level)
	local lines = {}
	local ordered_keys = {}
	local characters = 80

	for k in pairs(table_section) do
		table.insert(ordered_keys, k)
	end

	for i = 1, #ordered_keys do
		local key, value = ordered_keys[i], table_section[ordered_keys[i]]

		if string.match(key, '^#>') then
			if string.len(value.comment_chars .. ' ' .. value.copy) > characters then
				local prose_lines = format_prose(
					value.copy,
					characters,
					indent_level,
					value.comment_chars
				)

				for _, prose_line in ipairs(prose_lines) do
					table.insert(lines, prose_line)
				end
			else
				local line = string.format(
					'%s%s %s',
					string.rep(' ', 2 * indent_level),
					value.comment_chars,
					value.copy
				)
				table.insert(lines, line)
			end
		elseif type(value) == 'table' then
			-- TODO: handle list-like tables
			local line = string.format('%s%s:', string.rep(' ', 2 * indent_level), key)
			table.insert(lines, line)

			local table_section_lines = yaml_recurse(value, indent_level + 1)

			for _, section_line in ipairs(table_section_lines) do
				table.insert(lines, section_line)
			end
		else
			local line = string.format('%s%s: %q', string.rep(' ', 2 * indent_level), key, value)
			table.insert(lines, line)
		end
	end

	return lines
end

local YamlTable = {}
local YamlLines = {
	__tostring = function(self)
		return table.concat(self, '\n')
	end,
}

YamlTable.prototype = {
	tolines = function(self)
		local yaml_lines = yaml_recurse(self, 0)

		setmetatable(yaml_lines, YamlLines)

		return yaml_lines
	end,
}

YamlTable.mt = {
	__tostring = function(self)
		local lines = self:tolines()

		return table.concat(lines, '\n')
	end,
	__index = YamlTable.prototype,
}

YamlTable.new = function(o)
	setmetatable(o, YamlTable.mt)
	return o
end

M.YamlTable = YamlTable

function M.shipwright_build(should_set_colourscheme)
	if should_set_colourscheme then
		lush(require(vim.g.colors_name))
	end

	vim.cmd('Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/alacritty.lua')
	vim.cmd('Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/kitty.lua')
end

function M.setup()
	lush(require(vim.g.colors_name))

	api.nvim_command(
		[[ command! ApplyColourscheme lua require('lxs.plugin_settings.shipwright').shipwright_build(true) ]]
	)

	api.nvim_create_augroup('Shipwright', { clear = true })
	api.nvim_create_autocmd('VimEnter', {
		callback = function()
			M.shipwright_build(false)
		end,
	})
	api.nvim_create_autocmd('BufWritePost', {
		pattern = '*/crepuscular/**',
		callback = function()
			M.shipwright_build(true)
		end,
	})
end

return M
