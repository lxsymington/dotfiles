local Job = require('plenary.job')
local util = require('lspconfig.util')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local tbl_extend = vim.tbl_extend
local keymap = vim.api.nvim_set_keymap

local M = {}

-- TELESCOPE ---------------------------
function M.setup()
	local workspaces = {
		['conf'] = os.getenv('HOME') .. '/.dotfiles/nvim',
		['learning'] = os.getenv('HOME') .. '/Learning',
		['notes'] = os.getenv('HOME') .. '/.dotfiles/org/org_notes',
		['agenda'] = os.getenv('HOME') .. '/.dotfiles/org/org_agenda',
		['work_notes'] = os.getenv('HOME') .. '/Documents/Org/Notes',
		['work_agenda'] = os.getenv('HOME') .. '/Documents/Org/Agenda',
	}

	-- Using `ls -d */` errors at '*/' as it is treated as a string not a wildcard
	local project_job = Job
		:new({
			command = 'exa',
			args = { '-D' },
			cwd = os.getenv('HOME') .. '/Development/',
			on_stderr = function(_, err)
				vim.notify(string.format('Unable to create project workspaces: %s', err), 'error')
			end,
		})
		:sync(1000)

	local project_tables = vim.tbl_map(function(project)
		return { [project] = os.getenv('HOME') .. '/Development/' .. project }
	end, project_job)

	for _, project in ipairs(project_tables) do
		workspaces = tbl_extend('keep', workspaces, project)
	end

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
			frecency = {
				show_scores = true,
				ignore_patterns = { '*.git/*', '*/node_modules/*', '*/tmp/*' },
				workspaces = workspaces,
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

	-- Project
	keymap('n', '<Leader>pf', "<Cmd>:lua require('lxs.plugin_settings.telescope').fd()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap(
		'n',
		'<Leader>ps',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').project_search()<CR>",
		{ noremap = true, silent = true }
	)

	-- LSP
	keymap(
		'n',
		'<Leader>la',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_code_actions()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader>lar',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_range_code_actions()<CR>",
		{
			noremap = true,
			silent = true,
		}
	)
	keymap(
		'n',
		'<Leader>lr',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_references()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader>ld',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_document_diagnostics()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader>ldw',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_workspace_diagnostics()<CR>",
		{ noremap = true, silent = true }
	)

	-- Git
	keymap('n', '<Leader>gf', "<Cmd>:lua require('lxs.plugin_settings.telescope').git_files()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>gs', "<Cmd>:lua require('lxs.plugin_settings.telescope').git_status()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap(
		'n',
		'<Leader>gb',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').git_branches()<CR>",
		{ noremap = true, silent = true }
	)

	-- Vim
	keymap('n', '<Leader>vh', "<Cmd>:lua require('lxs.plugin_settings.telescope').help_tags()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>vm', "<Cmd>:lua require('lxs.plugin_settings.telescope').marks()<CR>", {
		noremap = true,
		silent = true,
	})

	-- Buffers
	keymap('n', '<Leader>bf', "<Cmd>:lua require('lxs.plugin_settings.telescope').buffers()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>b/', "<Cmd>:lua require('lxs.plugin_settings.telescope').curbuf()<CR>", {
		noremap = true,
		silent = true,
	})

	-- General
	keymap(
		'n',
		'<Leader><Tab>',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').file_browser()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader><Leader>',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').local_file_browser()<CR>",
		{ noremap = true, silent = true }
	)
	keymap('n', '<Leader>/', "<Cmd>:lua require('lxs.plugin_settings.telescope').live_grep()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>;', "<Cmd>:lua require('lxs.plugin_settings.telescope').symbols()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap(
		'n',
		'<Leader>hz',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').frecency()<CR>",
		{ noremap = true, silent = true }
	)
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

	builtin.file_browser(opts)
end

function M.local_file_browser()
	local opts = themes.get_cursor({
		cwd = vim.fn.expand('%:h'),
		layout_config = {
			mirror = true,
			height = math.min(math.floor(vim.o.lines * 0.8), 30),
		},
	})

	builtin.file_browser(opts)
end

function M.frecency()
	local opts = themes.get_dropdown({
		border = true,
		winblend = 10,
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
	local opts = themes.get_cursor({
		layout_strategy = 'vertical',
	})

	builtin.lsp_code_actions(opts)
end

function M.lsp_document_diagnostics()
	local opts = themes.get_ivy({})

	builtin.lsp_document_diagnostics(opts)
end

function M.lsp_range_code_actions()
	local opts = themes.get_cursor({
		layout_strategy = 'vertical',
	})

	builtin.lsp_range_code_actions(opts)
end

function M.lsp_references()
	local opts = themes.get_cursor({
		layout_strategy = 'vertical',
	})

	builtin.lsp_references(opts)
end

function M.lsp_workspace_diagnostics()
	local opts = themes.get_ivy({})

	builtin.lsp_workspace_diagnostics(opts)
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
