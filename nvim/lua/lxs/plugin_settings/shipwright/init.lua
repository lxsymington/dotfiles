local api = vim.api
local lush = require('lush')

local M = {}

local function yamlRecurse(tableSection, indent_level)
	local lines = {}

	P(ipairs(tableSection))

	for key, value in ipairs(tableSection) do
		-- TODO: handle list-like tables
		if type(value) == 'table' then
			local line = string.format(
				'%s%s:%s',
				string.rep(' ', 2 * indent_level),
				key,
				yamlRecurse(value, indent_level + 1)
			)
			P(line)
			table.insert(lines, line)
		else
			local line = string.format('%s%s: %q', string.rep(' ', 2 * indent_level), key, value)
			P(line)
			table.insert(lines, line)
		end

        P(key, value, line)
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
		local yaml_lines = yamlRecurse(self, 0)

		P(yaml_lines)
		setmetatable(yaml_lines, YamlLines)

		return yaml_lines
	end,
}

YamlTable.mt = {
	__tostring = function(table)
		local lines = table:tolines()

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
