local M = {}

---A unique key under which the OrderedTable indices are stored
local index_key = {}
---A unique key under which the OrderedTable entries are stored
local proxy_key = {}

---@class OrderedTable an object-like table that can be iterated over in order
---@field public add function add an entry to this `OrderedTable`
---@field public iter function iterates over the entries in the `OrderedTable` in order
local OrderedTable = {}

OrderedTable.prototype = {
    ---A convenience for assigning a new index
    ---@param self OrderedTable an ordered table to which the entry will be added
    ---@param key string|number|table the key of the entry to be created
    ---@param value any the value of the entry to be created
    add = function (self, key, value)
        self[key] = value
    end,
    ---A custom iterator for OrderedTables
    ---@param self OrderedTable an ordered table to iterate over
    ---@return function, OrderedTable, number - the iterator, ordered table and index
    iter = function (self)
        ---Internal iterator function
        ---@param _self OrderedTable the ordered table being iterated over
        ---@param index number the current index
        ---@return string, any entry the key and value
        local function _iter(_self, index)
            index = index + 1
            local indices = rawget(_self, index_key)
            local proxy = rawget(_self, proxy_key)
            local key = rawget(indices, index)
            local value = rawget(proxy, key)

            if key and value then
                return index, key, value
            end
        end

        return _iter, self, 0
    end
}

OrderedTable.mt = {
    ---The index metamethod of an OrderedTable
    ---@param self OrderedTable the ordered table upon which the index access is occurring
    ---@param key string|number|table the key or index of the entry being accessed
    ---@return any the value associated with the provided key or index
    __index = function (self, key)
        if OrderedTable.prototype[key] ~= nil then
            return OrderedTable.prototype[key]
        end

        if type(key) == "table" then
            return rawget(self, key)
        end

        if type(key) == "number" then
            local indices = rawget(self, index_key)
            local proxy = rawget(self, proxy_key)
            local store_key = rawget(indices, key)
            return store_key, rawget(proxy, store_key)
        end

        return self[proxy_key][key]
    end,
    ---The new index metamethod of an OrderedTable
    ---@param self OrderedTable the ordered table to which a property or method is being added
    ---@param key string|number|table the key or index under which the entry will created
    ---@param value any the value to be stored against the key
    __newindex = function (self, key, value)
        local index_keys = vim.tbl_keys(self[index_key])
        local next_key = table.maxn(index_keys) + 1
        self[index_key][next_key] = key
        self[proxy_key][key] = value
    end,
}

---The constructor function for OrderedTables
---@return OrderedTable a new OrderedTable
OrderedTable.new = function ()
    local store = {}
    local indices = {}
    local proxy = {}
    proxy[proxy_key] = store
    proxy[index_key] = indices
    setmetatable(proxy, OrderedTable.mt)
    return proxy
end

M.OrderedTable = OrderedTable

---Format prose as code comments
---@param prose string the text to be formatted
---@param characters number the maximum number of characters per line
---@param indent_level number the number of indents the lines should have
---@param comment_chars string the characters that will prefix each line to comment it out.
---@return string list a list of lines
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

---Convert lua tables to lines of yaml
---@param table_section YamlTable the table to convert to lines of yaml
---@param indent_level number the number of indents the line should have
---@return YamlLines a list of yaml lines
local function to_yaml_lines(table_section, indent_level)
	local lines = {}
	local characters = 80

	for _, key, value in table_section:iter() do
        if type(key) == 'string' then
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

                local table_section_lines = to_yaml_lines(value, indent_level + 1)

                for _, section_line in ipairs(table_section_lines) do
                    table.insert(lines, section_line)
                end
            else
                local line = string.format('%s%s: %q', string.rep(' ', 2 * indent_level), key, value)
                table.insert(lines, line)
            end
        end
	end

	return lines
end


---@class YamlLines a list of lines of yaml
local YamlLines = {
    ---The tostring method for YamlLines
    ---@param self string list the lines of yaml stored in this table
    ---@return string a concatenated string representation
	__tostring = function(self)
		return table.concat(self, '\n')
	end,
}

---@class YamlTable:OrderedTable a table that can be converted to yaml or lines of yaml
---@field public tolines function get the YamlLines for this YamlTable
local YamlTable = {}

YamlTable.prototype = {
    ---A method to convert a lua table into a list of lines
    ---@param self YamlTable the table to be converted to a list of lines of yaml
    ---@return YamlLines a list of lines of yaml
	tolines = function(self)
		local yaml_lines = to_yaml_lines(self, 0)

		setmetatable(yaml_lines, YamlLines)

		return yaml_lines
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
	__index = function (self, key)
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
    __metatable = OrderedTable
}

---The constructor function for YamlTables
---@return YamlTable a new YamlTable
YamlTable.new = function ()
    local store = {}
    local indices = {}
    local proxy = {}
    proxy[proxy_key] = store
    proxy[index_key] = indices
    setmetatable(proxy, YamlTable.mt)
    return proxy
end

M.YamlTable = YamlTable

return M
