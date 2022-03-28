local M = {}

local index_key = {}
local proxy_key = {}

---@class OrderedTable an object-like table that can be iterated over in order
local OrderedTable = {}

OrderedTable.prototype = {
    ---A convenience for assigning a new index
    ---@param self OrderedTable an ordered table to which the entry will be added
    ---@param key string|number|table the key of the entry to be created
    ---@param value any the value of the entry to be created
    add = function (self, key, value)
        self[key] = value
    end,
    ---A custom pairs iterator for OrderedTables
    ---@param self OrderedTable an ordered table to iterate over
    ---@return function a `pairs` iterator
    pairs = function (self)
        return pairs(self[proxy_key])
    end,
    --- A custom ipairs iterated for OrderedTables
    ---@param self OrderedTable an ordered table to iterate over
    ---@return function an `ipairs` iterator
    ipairs = function (self)
        return ipairs(self[index_key])
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

    P(table_section)

	for i = 1, #table_section do
		local key, value = table_section[i]

        print("key")
        P(key)
        print("value")
        P(value)

        if type(key) == string then
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

    print("lines")
    P(lines)

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
---@field public add function add an entry to this YamlTable
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
