local cmp = require('cmp')
local ls = require('luasnip')
local types = require('luasnip.util.types')
local lspkind = require('lspkind')

local M = {}

-- CMP ---------------------------------
local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
			== nil
end

function M.setup()
	ls.config.set_config({
		history = true,
	})

	ls.config.setup({
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { '●', 'Orange' } },
				},
			},
			[types.insertNode] = {
				active = {
					virt_text = { { '●', 'LightBlue' } },
				},
			},
		},
	})

	local function prevOption(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif ls.jumpable(-1) then
			ls.jump(-1)
		else
			fallback()
		end
	end

	local function nextOption(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif ls.expand_or_jumpable() then
			ls.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				-- For `luasnip` user.
				ls.lsp_expand(args.body)
			end,
		},
		mapping = {
			['<C-u>'] = cmp.mapping.scroll_docs(-4),
			['<C-d>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-p>'] = cmp.mapping(prevOption, { 'i', 's' }),
			['<C-n>'] = cmp.mapping(nextOption, { 'i', 's' }),
			['<C-e>'] = cmp.mapping.close(),
			['<C-y>'] = cmp.mapping.confirm({
				behaviour = cmp.ConfirmBehavior.Insert,
				select = true,
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
				maxwidth = 60,
			}),
		},
		experimental = {
			native_menu = false,
			ghost_text = true,
		},
	})
end

return M
