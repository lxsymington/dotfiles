local M = {}

-- LSP Handlers ------------------------
function M.setup()
	vim.lsp.handlers['textDocument/formatting'] = function(err, result, ctx, config)
		if err ~= nil or result == nil then
			vim.notify(tostring(err) or 'no result available', vim.log.levels.ERROR)
			return
		end

		if
			vim.api.nvim_buf_get_var(ctx.bufnr, 'init_changedtick')
			== vim.api.nvim_buf_get_var(ctx.bufnr, 'changedtick')
		then
			local view = vim.fn.winsaveview()
			local buffer_clients = vim.lsp.buf_get_clients(ctx.bufnr)
			local current_client = (buffer_clients[ctx.client_id])
			vim.lsp.util.apply_text_edits(result, ctx.bufnr, current_client.offset_encoding)
			vim.fn.winrestview(view)
			if ctx.bufnr == vim.api.nvim_get_current_buf() then
				vim.b.saving_format = true
				vim.cmd([[update]])
				vim.b.saving_format = false
			end
		end
	end

	vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
		vim.lsp.with(require('lsp_extensions.workspace.diagnostic').handler, {
			underline = true,
			virtual_text = { prefix = '🔎', source = 'always' },
			border = 'rounded',
		})(...)
		pcall(vim.diagnostic.setloclist, { open = false })
	end

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = 'rounded',
	})

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = 'rounded',
	})

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = 'rounded',
	})
end

return M
