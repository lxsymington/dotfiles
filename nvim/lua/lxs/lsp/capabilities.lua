local lsp_status = require('lsp-status')
local lsp = vim.lsp
local tbl_extend = vim.tbl_extend
local M = {}

-- LSP Capabilities --------------------
function M.create(opts)
	local capabilities = lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem = tbl_extend(
		'keep',
		capabilities.textDocument.completion.completionItem,
		{
			commitCharactersSupport = true,
			deprecatedSupport = true,
			documentationFormat = { 'markdown', 'plaintext' },
			insertReplaceSupport = true,
			labelDetailsSupport = true,
			preselectSupport = true,
			snippetSupport = true,
			tagSupport = { valueSet = { 1 } },
			resolveSupport = {
				properties = {
					'documentation',
					'detail',
					'additionalTextEdits',
				},
			},
		}
	)

	return tbl_extend('keep', opts or {}, capabilities or {}, lsp_status.capabilities)
end

return M