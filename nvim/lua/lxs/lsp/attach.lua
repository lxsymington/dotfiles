local lsp_status = require('lsp-status')
local lsp_format = require('lsp-format')
local lsp_format_config = require('lxs.lsp.formatting')
local lsp_keymaps = require('lxs.lsp.keymaps')
local api = vim.api
local M = {}

-- LSP Attach --------------------------
function M.attach(client, bufnr)
	api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	lsp_keymaps.setup(bufnr)

	lsp_status.on_attach(client)

	lsp_format_config.setup()

	lsp_format.on_attach(client)

	if client.config.flags then
		client.config.flags.allow_incremental_sync = true
	end

	if client.resolved_capabilities.document_highlight then
		-- Highlight the current symbol in the document
		-- Clear highlight when leaving the current symbol in the document
		api.nvim_create_augroup('LSP Document Highlight', { clear = true })
		api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})
		api.nvim_create_autocmd('CursorMoved', {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end

	-- stylua: ignore
	-- Rust is currently the only thing w/ inlay hints
	if api.nvim_buf_get_option(0, "filetype") == "rust" then
		api.nvim_create_augroup('InlayHints', { clear = true })
		api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'TabEnter' }, {
			pattern = '*.rs',
			callback = function()
				require('lsp_extensions').inlay_hints()
			end,
		})
		api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			pattern = '*.rs',
			callback = function()
				require('lsp_extensions').inlay_hints({ aligned = true, prefix = ' » ' })
			end,
		})
	end
end

return M
