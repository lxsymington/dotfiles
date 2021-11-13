local cmp = require('cmp')
local lspkind = require('lspkind')

local M = {}

-- CMP ---------------------------------
function M.setup()
	cmp.setup({
		snippet = {
			expand = function(args)
				-- For `luasnip` user.
				require('luasnip').lsp_expand(args.body)
			end,
		},
		mapping = {
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'buffer' },
			{ name = 'org' },
		},
		formatting = {
			format = lspkind.cmp_format({ with_text = false, maxwidth = 60 }),
		},
	})
end

return M
