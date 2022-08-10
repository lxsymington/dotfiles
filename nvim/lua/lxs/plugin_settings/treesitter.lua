local ts_configs = require('nvim-treesitter.configs')
local ts_parsers = require('nvim-treesitter.parsers')
local M = {}

-- TREESITTER --------------------------
function M.setup()
	local parser_config = ts_parsers.get_parser_configs()
	parser_config.org = {
		install_info = {
			url = 'https://github.com/milisims/tree-sitter-org',
			revision = 'main',
			files = { 'src/parser.c', 'src/scanner.cc' },
		},
		filetype = 'org',
	}

	ts_configs.setup({
		ensure_installed = 'all',
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { 'org' },
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = 'gnn',
				node_incremental = 'grn',
				scope_incremental = 'grc',
				node_decremental = 'grm',
			},
		},
		refactor = {
			enable = true,
			smart_rename = { enable = true, keymaps = { smart_rename = 'grr' } },
			highlight_definitions = { enable = true },
		},
		autopairs = { enable = true },
		indent = { enable = true },
		textobjects = {
			enable = true,
			select = {
				enable = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['ab'] = '@block.outer',
					['ac'] = '@class.outer',
					['af'] = '@function.outer',
					['ib'] = '@block.inner',
					['ic'] = '@class.inner',
					['if'] = '@function.inner',
				},
			},
			move = {
				enable = true,
				goto_next_start = {
					[']f'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']F'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[f'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[F'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['sp'] = '@parameter.inner',
					['sf'] = '@function.outer',
					['sc'] = '@class.outer',
					['ss'] = '@statement.outer',
					['sb'] = '@block.outer',
				},
				swap_previous = {
					['sP'] = '@parameter.inner',
					['sF'] = '@function.outer',
					['sC'] = '@class.outer',
					['sS'] = '@statement.outer',
					['sB'] = '@block.outer',
				},
			},
			lsp_interop = {
				enable = true,
				border = 'rounded',
				peek_definition_code = {
					['<leader>df'] = '@function.outer',
					['<leader>dF'] = '@class.outer',
				},
			},
		},
	})
end

return M
