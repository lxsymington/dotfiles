---@class OrderedTable an object-like table that can be iterated over in order
---@field public add function add an entry to this `OrderedTable`
---@field public iter function iterates over the entries in the `OrderedTable` in order
---@field protected __index_key table a unique key under which the OrderedTable indices are stored
---@field protected __proxy_key table a unique key under which the OrderedTable entries are stored
local OrderedTable = {}

OrderedTable.prototype = {
    __index_key = {},
    __proxy_key = {},
	---A convenience for assigning a new index
	---@param self OrderedTable an ordered table to which the entry will be added
	---@param key string|number|table the key of the entry to be created
	---@param value any the value of the entry to be created
	add = function(self, key, value)
		self[key] = value
	end,
	---A custom iterator for OrderedTables
	---@param self OrderedTable an ordered table to iterate over
	---@return function, OrderedTable, number - the iterator, ordered table and index
	iter = function(self)
		---Internal iterator function
		---@param _self OrderedTable the ordered table being iterated over
		---@param index number the current index
		---@return string, any entry the key and value
		local function _iter(_self, index)
			index = index + 1
			local indices = rawget(_self, _self.__index_key)
			local proxy = rawget(_self, _self.__proxy_key)
			local key = rawget(indices, index)
			local value = rawget(proxy, key)

			if key and value then
				return index, key, value
			end
		end

		return _iter, self, 0
	end,
}

OrderedTable.mt = {
	---The index metamethod of an OrderedTable
	---@param self OrderedTable the ordered table upon which the index access is occurring
	---@param key string|number|table the key or index of the entry being accessed
	---@return any the value associated with the provided key or index
	__index = function(self, key)
		if OrderedTable.prototype[key] ~= nil then
			return OrderedTable.prototype[key]
		end

		if type(key) == 'table' then
			return rawget(self, key)
		end

        local proxy = rawget(self, self.__proxy_key)

		if type(key) == 'number' then
			local indices = rawget(self, self.__index_key)
			local store_key = rawget(indices, key)
			return store_key, rawget(proxy, store_key)
		end

		return rawget(proxy, key)
	end,
	---The new index metamethod of an OrderedTable
	---@param self OrderedTable the ordered table to which a property or method is being added
	---@param key string|number|table the key or index under which the entry will created
	---@param value any the value to be stored against the key
	__newindex = function(self, key, value)
		local indices = rawget(self, self.__index_key)
		local index_keys = vim.tbl_keys(indices)
		local next_key = table.maxn(index_keys) + 1
		self[self.__index_key][next_key] = key
		self[self.__proxy_key][key] = value
	end,
}

---The constructor function for OrderedTables
---@return OrderedTable a new OrderedTable
OrderedTable.new = function()
	local proxy = {}
	local store = {}
	local indices = {}
	proxy[OrderedTable.prototype.proxy_key] = store
	proxy[OrderedTable.prototype.__index_key] = indices
	setmetatable(proxy, OrderedTable.mt)
	return proxy
end

return OrderedTable
