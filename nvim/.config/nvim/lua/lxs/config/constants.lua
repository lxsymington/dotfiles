local M = {}

-- Constants ---------------------------
local function toList(source)
	local result = {}

	for key, value in pairs(source) do
		table.insert(result, string.format('%s [%s]', value, string.lower(key)))
	end

	return result
end

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

M.kind_labels = toList(M.kind_symbols)

return M
