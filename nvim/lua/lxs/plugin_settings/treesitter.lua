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
		ignore_install = { 'haskell' },
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
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			lsp_interop = {
				enable = true,
				peek_definition_code = {
					['<Leader>df'] = '@function.outer',
					['<Leader>dF'] = '@class.outer',
				},
			},
		},
	})
end

return M
