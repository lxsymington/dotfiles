local cmd = vim.cmd
local lsp = vim.lsp
local tbl_isempty = vim.tbl_isempty
local M = {}

-- LSP Preview -------------------------
local function preview_location_callback(_, result)
	if result == nil or tbl_isempty(result) then
		return nil
	end

	lsp.util.preview_location(result[1], { border = 'rounded' })
end

function M.setup()
	cmd([[command! PeekDefinition lua require('lxs.lsp.preview').preview()]])
end

function M.preview()
	local params = lsp.util.make_position_params()
	return lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

return M
