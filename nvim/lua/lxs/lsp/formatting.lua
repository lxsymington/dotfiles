local M = {}

-- Formatting
local format_options_prettier = {
	tabWidth = 4,
	singleQuote = true,
	trailingComma = 'all',
	configPrecedence = 'prefer-file',
}

local format_options_stylua = {
	column_width = 100,
	indent_type = 'Tabs',
	indent_width = 4,
	line_endings = 'Unix',
	quote_style = 'AutoPreferSingle',
}

vim.g.format_options_css = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_javascript = format_options_prettier
vim.g.format_options_javascriptreact = format_options_prettier
vim.g.format_options_markdown = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_typescript = format_options_prettier
vim.g.format_options_typescriptreact = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_lua = format_options_stylua

local format_disabled_var = function()
	return string.format('format_disabled_%s', vim.bo.filetype)
end

local format_options_var = function()
	return string.format('format_options_%s', vim.bo.filetype)
end

M.formatToggle = function(value)
	local var = format_disabled_var()
	vim.g[var] = value ~= nil and value or not vim.g[var]
end

vim.cmd([[command! FormatDisable lua require'lxs.lsp.formatting'.formatToggle(true)]])
vim.cmd([[command! FormatEnable lua require'lxs.lsp.formatting'.formatToggle(false)]])

M.format = function()
	if not vim.b.saving_format and not vim.g[format_disabled_var()] then
		local file_path = vim.fn.expand('%:p')
		local relative_file_path = vim.fn.fnamemodify(file_path, ':~:.')
		vim.notify(string.format('Formatting – %s', relative_file_path), 'info')
		local format_options = vim.g[format_options_var()]
		vim.b.init_changedtick = vim.b.changedtick
		vim.lsp.buf.formatting(format_options or {})
	end
end

return M
