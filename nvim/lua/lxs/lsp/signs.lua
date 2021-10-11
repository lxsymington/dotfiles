local sign_define = vim.fn.sign_define
local M = {}

-- LSP Signs ---------------------------
function M.setup()
	sign_define('LspDiagnosticsSignError', {
		text = '',
		texthl = 'LspDiagnosticsSignError',
	})

	sign_define('LspDiagnosticsSignWarning', {
		text = '',
		texthl = 'LspDiagnosticsSignWarning',
	})

	sign_define('LspDiagnosticsSignInformation', {
		text = '',
		texthl = 'LspDiagnosticsSignInformation',
	})

	sign_define('LspDiagnosticsSignHint', {
		text = '',
		texthl = 'LspDiagnosticsSignHint',
	})
end

return M
