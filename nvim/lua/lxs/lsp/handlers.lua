local M = {}

-- LSP Handlers ------------------------
function M.setup()
	vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		local lvl = ({
			'ERROR',
			'WARN',
			'INFO',
			'DEBUG',
		})[result.type]

		vim.notify({ result.message }, lvl, {
			title = 'LSP | ' .. client.name,
			timeout = 10000,
			keep = function()
				return lvl == 'ERROR' or lvl == 'WARN'
			end,
		})
	end

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = 'rounded',
	})

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = 'rounded',
	})
end

return M
