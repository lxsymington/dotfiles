local wk = require('which-key')
local M = {}

-- LSP Keymaps -------------------------
---@param bufnr buffer number (number)
function M.setup(bufnr)
	wk.register({
		['<Leader>'] = {
			['-'] = {
				'<Cmd>:lua vim.diagnostic.setloclist()<CR>',
				'Add buffer diagnostics to the location list',
			},
			['@'] = {
				'<Cmd>:PeekDefinition<CR>',
				'Peek definition',
			},
			ca = {
				'<Cmd>:lua vim.lsp.buf.code_action()<CR>',
				'LSP code action',
			},
			g = {
				d = {
					'<Cmd>:lua vim.lsp.buf.definition()<CR>',
					'Go to definition',
				},
				i = {
					'<Cmd>:lua vim.lsp.buf.implementation()<CR>',
					'Go to implementation',
				},
				r = {
					'<Cmd>:lua vim.lsp.buf.references()<CR>',
					'Go to references',
				},
				t = {
					'<Cmd>:lua vim.lsp.buf.type_definition()<CR>',
					'Go to type definition',
				},
			},
			r = {
				'<Cmd>:lua vim.lsp.buf.rename()<CR>',
				'Rename symbol',
			},
			sh = {
				'<Cmd>:lua vim.lsp.buf.signature_help()<CR>',
				'Signature help',
			},
			wd = {
				'<Cmd>:lua require("lsp_extensions.workspace.diagnostic").set_qf_list()<CR>',
				'Workspace diagnostics',
			},
		},
		K = {
			'<Cmd>:lua vim.lsp.buf.hover()<CR>',
			'Lsp hover',
		},
		['['] = {
			d = {
				'<Cmd>:lua vim.diagnostic.goto_next({ float = { border = "rounded", source = "if_many" }})<CR>',
				'Previous diagnostic',
			},
		},
		[']'] = {
			d = {
				'<Cmd>:lua vim.diagnostic.goto_next({ float = { border = "rounded", source = "if_many" }})<CR>',
				'Next diagnostic',
			},
		},
	}, {
		buffer = bufnr,
		mode = 'n',
		noremap = true,
		silent = true,
	})
end

return M
