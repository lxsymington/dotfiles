local keymap = vim.api.nvim_set_keymap
local util = require('lspconfig.util')

local should_reload = true
local reloader = function()
	if should_reload then
		RELOAD('plenary')
		RELOAD('popup')
		RELOAD('telescope')
	end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

local M = {}

-- TELESCOPE ---------------------------
function M.setup()
	require('telescope').setup({
		defaults = {
			layout_strategy = 'flex',
			layout_config = {
				width = 0.95,
				height = 0.85,
				prompt_position = 'top',

				flex = {
					horizontal = {
						preview_width = function(_, cols, _)
							if cols > 200 then
								return math.floor(cols * 0.6)
							else
								return math.floor(cols * 0.5)
							end
						end,
					},
					vertical = {
						width = 0.9,
						height = 0.95,
						preview_height = 0.5,
					},
				},
			},
			prompt_prefix = '🔭 ➜ ',
			scroll_strategy = 'cycle',
			selection_caret = '✯ ',
			winblend = 10,
		},
		extensions = {
			frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { '*.git/*', '*/node_modules/*', '*/tmp/*' },
				workspaces = {
					['conf'] = os.getenv('HOME') .. '/.config',
					['data'] = os.getenv('HOME') .. '/.local/share',
					['development'] = os.getenv('HOME') .. '/Development',
					['learning'] = os.getenv('HOME') .. '/Learning',
				},
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = 'smart_case',
			},
		},
	})

	require('telescope').load_extension('fzf')
	require('telescope').load_extension('frecency')

	-- Project
	keymap(
		'n',
		'<Leader>p',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').file_browser()<CR>",
		{ noremap = true, silent = true }
	)
	keymap('n', '<Leader>pfd', "<Cmd>:lua require('lxs.plugin_settings.telescope').fd()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap(
		'n',
		'<Leader>pf',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').frecency()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader>ps',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').project_search()<CR>",
		{ noremap = true, silent = true }
	)
	keymap('n', '<Leader>p/', "<Cmd>:lua require('lxs.plugin_settings.telescope').live_grep()<CR>", {
		noremap = true,
		silent = true,
	})

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
end

function M.curbuf()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		path_display = { 'shorten' },
	})

	builtin.current_buffer_fuzzy_find(opts)
end

function M.file_browser()
	local opts = themes.get_ivy({
		cwd = util.root_pattern('.git')(vim.fn.expand('%')),
	})

	builtin.file_browser(opts)
end

function M.frecency()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
	})

	require('telescope').extensions.frecency.frecency(opts)
end

function M.lsp_code_actions()
	local opts = themes.get_cursor({
		layout_strategy = vertical,
	})

	builtin.lsp_code_actions(opts)
end

function M.lsp_range_code_actions()
	local opts = themes.get_cursor({
		layout_strategy = vertical,
	})

	builtin.lsp_range_code_actions(opts)
end

function M.lsp_references()
	local opts = themes.get_cursor({
		layout_strategy = vertical,
	})

	builtin.lsp_references(opts)
end

function M.lsp_document_diagnostics()
	local opts = themes.get_ivy({})

	builtin.lsp_document_diagnostics(opts)
end

function M.lsp_workspace_diagnostics()
	local opts = themes.get_ivy({})

	builtin.lsp_workspace_diagnostics(opts)
end

function M.git_status()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		path_display = { 'shorten' },
	})

	builtin.git_status(opts)
end

function M.project_search()
	builtin.find_files({
		layout_strategy = 'vertical',
		cwd = util.root_pattern('.git')(vim.fn.expand('%:p')),
	})
end

return setmetatable({}, {
	__index = function(_, k)
		reloader()

		if M[k] then
			return M[k]
		else
			return builtin[k]
		end
	end,
})
