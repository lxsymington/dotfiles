local buf_keymap = vim.api.nvim_buf_set_keymap
local M = {}

-- LSP Keymaps -------------------------
---@param bufnr (number)
function M.setup(bufnr)
	local function keymap(...)
		buf_keymap(bufnr, ...)
	end

	local keymap_opts = { noremap = true, silent = true }

	-- Go to definition
	keymap('n', '<Leader>gd', '<Cmd>:lua vim.lsp.buf.definition()<CR>', keymap_opts)

	-- Peek definition
	keymap('n', '<Leader>@', '<Cmd>:PeekDefinition<CR>', keymap_opts)

	-- Go to implementation
	keymap('n', '<Leader>gi', '<Cmd>:lua vim.lsp.buf.implementation()<CR>', keymap_opts)

	-- Go to type definition
	keymap('n', '<Leader>gtd', '<Cmd>:lua vim.lsp.buf.type_definition()<CR>', keymap_opts)

	-- Go to references
	keymap('n', '<Leader>gr', '<Cmd>:lua vim.lsp.buf.references()<CR>', keymap_opts)

	-- Code action
	keymap('n', '<Leader>ca', '<Cmd>:lua vim.lsp.buf.code_action()<CR>', keymap_opts)

	-- Rename
	keymap('n', '<Leader>r', '<Cmd>:lua vim.lsp.buf.rename()<CR>', keymap_opts)

	-- Hover
	keymap('n', 'K', '<Cmd>:lua vim.lsp.buf.hover()<CR>', keymap_opts)

	-- Open diagnostics
	keymap('n', '<Leader>-', '<Cmd>:lua vim.lsp.diagnostic.set_loclist()<CR>', keymap_opts)

	-- Signature help
	keymap('n', '<Leader>sh', '<Cmd>:lua vim.lsp.buf.signature_help()<CR>', keymap_opts)

	-- Go to next diagnostic
	keymap(
		'n',
		']d',
		'<Cmd>:lua vim.lsp.diagnostic.goto_next({ float = { border = "rounded", source = "if_many" }})<CR>',
		keymap_opts
	)

	-- Go to previous diagnostic
	keymap(
		'n',
		'[d',
		'<Cmd>:lua vim.lsp.diagnostic.goto_prev({ float = { border = "rounded", source = "if_many" }})<CR>',
		keymap_opts
	)

	-- View workspace diagnostics
	keymap(
		'n',
		'<Leader>wd',
		"<Cmd>:lua require('lsp_extensions.workspace.diagnostic').set_qf_list()<CR>",
		keymap_opts
	)
end

return M
