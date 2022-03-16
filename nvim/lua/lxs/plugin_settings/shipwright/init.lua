local api = vim.api
local lush = require('lush')

local M = {}

local function yaml_recurse(table_section, indent_level)
	local lines = {}
	local ordered_keys = {}

    for k in pairs(table_section) do
        table.insert(ordered_keys, k)
    end

    table.sort(ordered_keys)

	for i = 1, #ordered_keys do
		-- TODO: handle list-like tables
		local key, value = ordered_keys[i], table_section[ordered_keys[i]]
		if type(value) == 'table' then
			local line = string.format(
				'%s%s:',
				string.rep(' ', 2 * indent_level),
				key
			)
			table.insert(lines, line)

		    local table_section_lines = yaml_recurse(value, indent_level + 1)

		    for i, section_line in ipairs(table_section_lines) do
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

function M.setup()
	lush(require(vim.g.colors_name))

	local function runShipwright()
		vim.cmd('Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/alacritty.lua')
		vim.cmd('Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/kitty.lua')
	end

	api.nvim_create_augroup('Shipwright', { clear = true })
	api.nvim_create_autocmd('VimEnter', {
		callback = runShipwright,
	})
	api.nvim_create_autocmd('BufWritePost', {
		pattern = '*/crepuscular/**',
		callback = runShipwright,
	})
end

return M
