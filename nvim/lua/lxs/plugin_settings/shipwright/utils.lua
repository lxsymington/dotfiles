local M = {}

local index_key = {}
local key_index = {}

M.mt = {
    __index = function (self, key)
        if type(key) == "number" then
            return self[index_key][key]
        end
        local index  = self[key_index][key]
        return self[index_key][index]
    end,
    __newindex = function (self, key, value)
        local index_keys = vim.tbl_keys(self[index_key])
        local next_key = math.max(unpack(index_keys)) + 1
        self[index_key][next_key] = { key, value }
        self[key_index][key] = next_key
    end
}

return M
