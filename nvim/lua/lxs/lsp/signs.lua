local sign_define = vim.fn.sign_define
local M = {}

-- LSP Signs ---------------------------
function M.setup()
	sign_define('DiagnosticSignError', {
		text = '',
		texthl = 'DiagnosticSignError',
	})

	sign_define('DiagnosticSignWarn', {
		text = '',
		texthl = 'DiagnosticSignWarn',
	})

	sign_define('DiagnosticSignInfo', {
		text = '',
		texthl = 'DiagnosticSignInfo',
	})

	sign_define('DiagnosticSignHint', {
		text = '',
		texthl = 'DiagnosticSignHint',
	})
end

return M
