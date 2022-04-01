local OrderedTable = require('lxs.utils.ordered_table')

---A unique key under which the OrderedTable indices are stored
local index_key = {}
---A unique key under which the OrderedTable entries are stored
local proxy_key = {}

---@class YamlLines a list of lines of yaml
---@field concat function join all entries in the list with a string
local YamlLines = {}

YamlLines.prototype = {}

YamlLines.mt = {
	---The index metamethod of an YamlLines
	__index = table,
	---The tostring method for YamlLines
	---@param self YamlLines the lines of yaml stored in this table
	---@return string a concatenated string representation
	__tostring = function(self)
		return self:concat('\n')
	end,
}

YamlLines.new = function()
	local new = {}
	setmetatable(new, YamlLines.mt)
	return new
end

---@class YamlTableConfig the configuration table for YamlTables
---@field characters number the maximum characters per line for comments
---@field comment_prefix string the prefix to use when adding a comment to the YamlTable
---@field separator string a string to be used as the separator betweens keys and values
---@field indent_char string a string to be used as the indent character
---@field indent_size number the number of `indent_char`s to use per indent_level
local YamlTableConfig = {}

---@class YamlTable:OrderedTable a table that can be converted to yaml or lines of yaml
---@field public tolines function get the YamlLines for this YamlTable
---@field private format_prose function formats prose
---@field private config YamlTableConfig the configuration for this YamlTable
local YamlTable = {}

YamlTable.prototype = {
	---Format prose as code comments
	---@param self YamlTable the YamlTable itself
	---@param prose string the text to be formatted
	---@param indent_level number the number of indents the lines should have
	---@param comment_chars string the characters that will prefix each line to comment it out.
	---@return string list a list of lines
	format_prose = function(self, prose, indent_level, comment_chars)
		local lines = YamlLines:new()
		local config = rawget(self, 'config')

		local line = string.format(
			'%s%s',
			string.rep(config.indent_char, config.indent_size * indent_level),
			comment_chars
		)

		for word in string.gmatch(prose, '[^%s]+') do
			if string.len(line .. ' ' .. word) < config.characters then
				line = string.format('%s %s', line, word)
			else
				lines:insert(line)
				line = string.format(
					'%s%s %s',
					string.rep(config.indent_char, config.indent_size * indent_level),
					comment_chars,
					word
				)
			end
		end

		return lines
	end,
	---Convert lua tables to lines of yaml
	---@param self YamlTable the table to convert to lines of yaml
	---@param indent_level number the number of indents the line should have
	---@return YamlLines a list of yaml lines
	tolines = function(self, indent_level)
		indent_level = indent_level or 0
		local lines = YamlLines:new()
		local config = rawget(self, 'config')

		for _, key, value in self:iter() do
			if type(key) == 'string' then
				if string.match(key, '^' .. config.comment_prefix) then
					if string.len(value.comment_chars .. ' ' .. value.copy) > config.characters then
						local prose_lines = self:format_prose(
							value.copy,
							indent_level,
							value.comment_chars
						)

						for _, prose_line in ipairs(prose_lines) do
							lines:insert(prose_line)
						end
					else
						local line = string.format(
							'%s%s %s',
							string.rep(config.indent_char, config.indent_size * indent_level),
							value.comment_chars,
							value.copy
						)
						lines:insert(line)
					end
				elseif type(value) == 'table' then
					-- TODO: handle list-like tables
					local line = string.format(
						'%s%s%s',
						string.rep(config.indent_char, config.indent_size * indent_level),
						key,
						config.separator
					)
					lines:insert(line)

					local table_section_lines = value:tolines(indent_level + 1)

					for _, section_line in ipairs(table_section_lines) do
						lines:insert(section_line)
					end
				else
					local line = string.format(
						'%s%s%s %s',
						string.rep(config.indent_char, config.indent_size * indent_level),
						key,
						config.separator,
						value
					)
					lines:insert(line)
				end
			end
		end

		return lines
	end,
}

YamlTable.mt = {
	---The tostring metamethod for YamlTable
	---@param self YamlTable the table to convert to a yaml string
	---@return string a yaml string
	__tostring = function(self)
		local lines = self:tolines()

		return table.concat(lines, '\n')
	end,
	---The index metamethod for YamlTable
	---@param self YamlTable the yaml table upon which the index access is occurring
	---@param key string|number|table the key or index of the entry being accessed
	---@return any the value associated with the provided key
	__index = function(self, key)
		local inherited = getmetatable(self)
		if YamlTable.prototype[key] ~= nil then
			return YamlTable.prototype[key]
		elseif inherited[key] ~= nil then
			return inherited[key]
		else
			return inherited.mt.__index(self, key)
		end
	end,
	__newindex = OrderedTable.mt.__newindex,
	---Inherit from OrderedTable
	__metatable = OrderedTable,
}

---The constructor function for YamlTables
---@param config YamlTableConfig a configuration table for this YamlTable
---@return YamlTable a new YamlTable
YamlTable.new = function(_, config)
	local store = {}
	local indices = {}
	local proxy = {}
	proxy[proxy_key] = store
	proxy[index_key] = indices
	proxy.config = config
	setmetatable(proxy, YamlTable.mt)
	return proxy
end

return YamlTable
