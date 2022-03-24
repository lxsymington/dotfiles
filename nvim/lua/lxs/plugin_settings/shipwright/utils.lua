local M = {}

local OrderedTable = {}
local index_key = {}
local key_index = {}

OrderedTable.prototype = {
    add = function (self, key, value)
        self[key] = value
    end
}

OrderedTable.mt = {
    __index = function (self, key)
        print("*access to element " .. tostring(key))
        if OrderedTable.prototype[key] ~= nil then
            return OrderedTable.prototype[key]
        end
        if type(key) == "table" then
            print("accessing index table")
            return self[key]
        end
        if type(key) == "number" then
            print("retrieving value from index table")
            return self[index_key][key]
        end

        print("retrieving index by key")
        local index = self[key_index][key]
        print("retrieving value from index table via index obtained with key")
        return self[index_key][index]
    end,
    __newindex = function (self, key, value)
        print("*update of element " .. tostring(key) .. " to " .. tostring(value))
        P(self[index_key])
        P(self[key_index])
        local index_keys = vim.tbl_keys(self[index_key])
        local next_key = math.max(unpack(index_keys)) + 1
        print("next key is " .. tostring(next_key))
        self[index_key][next_key] = { key, value }
        self[key_index][key] = next_key
        P(self[index_key])
        P(self[key_index])
    end
}

OrderedTable.new = function ()
    local new = {}

    setmetatable(new, OrderedTable.mt)

    return new
end

M.OrderedTable = OrderedTable

return M
