local keymap = vim.api.nvim_set_keymap

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
			--[[ frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/node_modules/*", "*/tmp/*" },
				workspaces = {
					["conf"] = os.getenv("HOME") .. "/.config",
					["data"] = os.getenv("HOME") .. "/.local/share",
					["development"] = os.getenv("HOME") .. "/Development",
					["learning"] = os.getenv("HOME") .. "/Learning",
				},
			}, ]]
			fzy_native = {
				override_generic_sorter = true,
				override_file_sorter = true,
			},
		},
	})

	-- require("telescope").load_extension("frecency")
	require('telescope').load_extension('fzy_native')

	keymap(
		'n',
		'<Leader><Tab>',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').file_browser()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader><space>',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_code_actions()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader>?',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_range_code_actions()<CR>",
		{
			noremap = true,
			silent = true,
		}
	)
	keymap('n', '<Leader>fb', "<Cmd>:lua require('lxs.plugin_settings.telescope').buffers()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>fd', "<Cmd>:lua require('lxs.plugin_settings.telescope').fd()<CR>", {
		noremap = true,
		silent = true,
	})
	--[[ keymap(
		"n",
		"<Leader>ff",
		"<Cmd>:lua require('lxs.plugin_settings.telescope').frecency()<CR>",
		{ noremap = true, silent = true }
	) ]]
	keymap('n', '<Leader>fgf', "<Cmd>:lua require('lxs.plugin_settings.telescope').git_files()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>fht', "<Cmd>:lua require('lxs.plugin_settings.telescope').help_tags()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap(
		'n',
		'<Leader>fpf',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').project_search()<CR>",
		{ noremap = true, silent = true }
	)
	keymap(
		'n',
		'<Leader>gb',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').git_branches()<CR>",
		{ noremap = true, silent = true }
	)
	keymap('n', '<Leader>gs', "<Cmd>:lua require('lxs.plugin_settings.telescope').git_status()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>lbg', "<Cmd>:lua require('lxs.plugin_settings.telescope').curbuf()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap('n', '<Leader>lg', "<Cmd>:lua require('lxs.plugin_settings.telescope').live_grep()<CR>", {
		noremap = true,
		silent = true,
	})
	keymap(
		'n',
		'<Leader>sr',
		"<Cmd>:lua require('lxs.plugin_settings.telescope').lsp_references()<CR>",
		{ noremap = true, silent = true }
	)
end

function M.project_search()
	builtin.find_files({
		previewer = false,
		layout_strategy = 'vertical',
		cwd = require('nvim_lsp.util').root_pattern('.git')(vim.fn.expand('%:p')),
	})
end

function M.curbuf()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})

	builtin.current_buffer_fuzzy_find(opts)
end

--[[ function M.frecency()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		shorten_path = false,
	})

	require("telescope").extensions.frecency.frecency(opts)
end ]]

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
