local M = {}

-- Constants ---------------------------
M.kind_symbols = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '塞',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    Type = '',
}

local meta_kind = {
    items = function(table)
        local result = {}

        for key, value in pairs(table) do
            table.insert(result, string.format('%s [%s]', value, string.lowercase(key)))
        end

        return result
    end
}

setmetatable(M.kind_symbols, meta_kind)

return M
