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
			['<C-y>'] = cmp.mapping.confirm({
			    behaviour = cmp.ConfirmBehavior.Insert,
			    select = true
			}),
		},
		sources = {
			{ name = 'org' },
			{ name = 'nvim_lua' },
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'path' },
			{ name = 'buffer', keyword_length = 4 },
		},
		formatting = {
			format = lspkind.cmp_format({
			    with_text = false,
			    menu = {
			        org = '⎨ 🦄',
			        nvim_lua = '⎨ ',
			        nvim_lsp = '⎨ ',
			        luasnip = '⎨ ✂️',
			        path = '⎨ 🌲',
			        buffer = '⎨ 📄',
			    },
			    maxwidth = 60
            }),
		},
		experimental = {
		    native_menu = false,
		    ghost_text = true,
		}
	})
end

return M
