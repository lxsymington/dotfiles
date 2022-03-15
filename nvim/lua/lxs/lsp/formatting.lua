local lsp_format = require('lsp-format')
local M = {}

-- Formatting
function M.setup()
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

	lsp_format.setup({
		css = format_options_prettier,
		html = format_options_prettier,
		javascript = format_options_prettier,
		javascriptreact = format_options_prettier,
		markdown = format_options_prettier,
		scss = format_options_prettier,
		typescript = format_options_prettier,
		typescriptreact = format_options_prettier,
		yaml = format_options_prettier,
		lua = format_options_stylua,
	})
end

return M
