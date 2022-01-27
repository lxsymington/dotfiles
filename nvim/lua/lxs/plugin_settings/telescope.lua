local Job = require('plenary.job')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local util = require('lspconfig.util')
local wk = require('which-key')
local tbl_extend = vim.tbl_extend

local M = {}

local workspaces = {
	['conf'] = os.getenv('HOME') .. '/.dotfiles/nvim',
	['learning'] = os.getenv('HOME') .. '/Learning',
	['notes'] = os.getenv('HOME') .. '/.dotfiles/org/org_notes',
	['agenda'] = os.getenv('HOME') .. '/.dotfiles/org/org_agenda',
	['work_notes'] = os.getenv('HOME') .. '/Documents/Org/Notes',
	['work_agenda'] = os.getenv('HOME') .. '/Documents/Org/Agenda',
}

local function initWorkspaces()
	-- Using `ls -d */` errors at '*/' as it is treated as a string not a wildcard
	-- It may be possible not to use the `sync` version but plenary's docs aren't terribly clear
	local projects = Job
		:new({
			command = 'exa',
			args = { '-D' },
			cwd = os.getenv('HOME') .. '/Development/',
			on_stderr = function(_, err)
				vim.notify(string.format('Unable to create project workspaces: %s', err), 'error')
			end,
		})
		:sync(1000)

	for _, project in ipairs(projects) do
		workspaces = tbl_extend(
			'keep',
			workspaces,
			{ [project] = os.getenv('HOME') .. '/Development/' .. project }
		)
	end

	return workspaces
end

-- TELESCOPE ---------------------------
function M.setup()
	require('telescope').setup({
		defaults = {
			layout_strategy = 'flex',
			layout_config = {
				width = function(_, cols, _)
					return math.min(240, math.floor(cols * 0.8))
				end,
				height = function(_, _, lines)
					return math.min(60, math.floor(lines * 0.75))
				end,
				prompt_position = 'top',
				flex = {
					horizontal = {
						preview_width = function(_, cols, _)
							return math.min(120, math.floor(cols * 0.6 * 0.8))
						end,
					},
					vertical = {
						width = function(_, cols, _)
							return math.min(120, math.floor(cols * 0.8))
						end,
						preview_height = function(_, _, lines)
							return math.min(45, math.floor(lines * 0.5))
						end,
					},
				},
			},
			prompt_prefix = '🔭 ➜ ',
			scroll_strategy = 'cycle',
			selection_caret = '➜ ',
			winblend = 10,
		},
		extensions = {
			file_browser = {
				theme = 'ivy',
			},
			frecency = {
				show_scores = true,
				ignore_patterns = { '*.git/*', '*/node_modules/*', '*/tmp/*' },
				workspaces = initWorkspaces(),
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = 'smart_case',
			},
		},
	})

	pcall(require('telescope').load_extension, 'frecency')
	pcall(require('telescope').load_extension, 'fzf')
	pcall(require('telescope').load_extension, 'file_browser')

	wk.register({
		['<Leader>'] = {
			b = {
				name = 'Buffers',
				f = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").buffers()<CR>',
					'Find',
				},
				['/'] = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").curbuf()<CR>',
				},
			},
			g = {
				name = 'Telescope Git',
				b = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").git_branches()<CR>',
					'Branches',
				},
				f = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").git_files()<CR>',
					'Files',
				},
				s = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").git_status()<CR>',
					'Status',
				},
			},
			hz = {
				'<Cmd>:lua require("lxs.plugin_settings.telescope").frecency()<CR>',
				'Telescope frecency',
			},
			l = {
				name = 'Telescope LSP',
				c = {
					name = 'Code action',
					c = {
						'<Cmd>:lua require("lxs.plugin_settings.telescope").lsp_code_actions()<CR>',
						'Cursor',
					},
					r = {
						'<Cmd>:lua require("lxs.plugin_settings.telescope").lsp_range_code_actions()<CR>',
						'Range',
					},
				},
				d = {
					name = 'Diagnostics',
					d = {
						'<Cmd>:lua require("lxs.plugin_settings.telescope").lsp_document_diagnostics()<CR>',
						'Document',
					},
					w = {
						'<Cmd>:lua require("lxs.plugin_settings.telescope").lsp_workspace_diagnostics()<CR>',
						'Workspace',
					},
				},
				r = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").lsp_references()<CR>',
					'References',
				},
				s = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").lsp_dynamic_workspace_symbols()<CR>',
					'Symbols',
				},
			},
			p = {
				name = 'Telescope Project',
				s = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").project_search()<CR>',
					'Search',
				},
				f = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").fd()<CR>',
					'`fd` find',
				},
			},
			v = {
				name = 'Telescope Vim',
				h = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").help_tags()<CR>',
					'Help tags',
				},
				m = {
					'<Cmd>:lua require("lxs.plugin_settings.telescope").marks()<CR>',
					'Marks',
				},
			},
			['/'] = {
				'<Cmd>:lua require("lxs.plugin_settings.telescope").live_grep()<CR>',
				'Telescope live grep',
			},
			[';'] = {
				'<Cmd>:lua require("lxs.plugin_settings.telescope").symbols()<CR>',
				'Telescope font symbols',
			},
			['<Leader>'] = {
				'<Cmd>:lua require("lxs.plugin_settings.telescope").local_file_browser()<CR>',
				'Telescope local file browser',
			},
			['<Tab>'] = {
				'<Cmd>:lua require("lxs.plugin_settings.telescope").file_browser()<CR>',
				'Telescope file browser',
			},
		},
	}, {
		mode = 'n',
		noremap = true,
		silent = true,
	})
end

function M.curbuf()
	local opts = themes.get_dropdown({
		border = true,
		path_display = { shorten = 3 },
		previewer = false,
		winblend = 10,
	})

	builtin.current_buffer_fuzzy_find(opts)
end

function M.file_browser()
	local opts = themes.get_ivy({
		cwd = util.root_pattern('.git')(vim.fn.expand('%')),
	})

	require('telescope').extensions.file_browser.file_browser(opts)
end

function M.local_file_browser()
	local opts = themes.get_cursor({
		cwd = vim.fn.expand('%:h'),
		layout_config = {
			height = math.min(math.floor(vim.o.lines * 0.8), 30),
			preview_width = math.min(math.floor(vim.o.columns * 0.5), 80),
			width = math.min(math.floor(vim.o.columns * 0.8), 140),
		},
	})

	require('telescope').extensions.file_browser.file_browser(opts)
end

function M.frecency()
	local opts = themes.get_dropdown({
		border = true,
	})

	require('telescope').extensions.frecency.frecency(opts)
end

function M.git_status()
	local opts = themes.get_dropdown({
		border = true,
		path_display = { shorten = 3 },
		winblend = 10,
	})

	builtin.git_status(opts)
end

function M.lsp_code_actions()
	local opts = themes.get_cursor({})

	builtin.lsp_code_actions(opts)
end

function M.lsp_document_diagnostics()
	local opts = themes.get_ivy({
		bufnr = 0
	})

	builtin.diagnostics(opts)
end

function M.lsp_range_code_actions()
	local opts = themes.get_cursor({})

	builtin.lsp_range_code_actions(opts)
end

function M.lsp_references()
	local opts = themes.get_ivy({})

	builtin.lsp_references(opts)
end

function M.lsp_workspace_diagnostics()
	local opts = themes.get_ivy({})

	builtin.diagnostics(opts)
end

function M.project_search()
	builtin.find_files({
		layout_strategy = 'vertical',
		cwd = util.root_pattern('.git')(vim.fn.expand('%:p')),
	})
end

function M.symbols()
	local opts = themes.get_cursor({
		border = true,
	})

	builtin.symbols(opts)
end

return setmetatable({}, {
	__index = function(_, k)
		if M[k] then
			return M[k]
		else
			return builtin[k]
		end
	end,
})
