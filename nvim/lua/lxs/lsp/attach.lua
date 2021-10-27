local lsp_status = require('lsp-status')
local lsp_keymaps = require('lxs.lsp.keymaps')
local api = vim.api
local M = {}

-- LSP Attach --------------------------
function M.attach(client, bufnr)
	api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	lsp_keymaps.setup(bufnr)

	lsp_status.on_attach(client)

	if client.config.flags then
		client.config.flags.allow_incremental_sync = true
	end

	if
		client.resolved_capabilities.document_formatting
		or client.resolved_capabilities.documentFormatting
	then
		api.nvim_exec(
			[[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> lua require('lxs.lsp.formatting').format()
            augroup END
        ]],
			true
		)
	end

	if client.resolved_capabilities.document_highlight then
		-- Highlight the current symbol in the document
		-- Clear highlight when leaving the current symbol in the document
		api.nvim_exec(
			[[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
			false
		)
	end

	-- stylua: ignore
	-- Rust is currently the only thing w/ inlay hints
	if vim.api.nvim_buf_get_option(0, "filetype") == "rust" then
		api.nvim_exec(
			[[
            augroup InlayHints
            autocmd! * <buffer>
            autocmd BufEnter,BufWinEnter,TabEnter *.rs lua require('lsp_extensions').inlay_hints({})
            autocmd CursorHold,CursorHoldI *.rs lua require('lsp_extensions').inlay_hints({ aligned = true, prefix = " » " })
            augroup END
        ]],
			false
		)
	end
end

return M
