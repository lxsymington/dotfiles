local Job = require('plenary.job')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local util = require('lspconfig.util')
local keymap = vim.keymap
local tbl_extend = vim.tbl_extend

local M = {}

local home_dir = os.getenv('HOME')

local workspaces = {
	['conf'] = home_dir .. '/.dotfiles/nvim',
	['learning'] = home_dir .. '/Learning',
	['notes'] = home_dir .. '/.dotfiles/org/org_notes',
	['agenda'] = home_dir .. '/.dotfiles/org/org_agenda',
	['work_notes'] = home_dir .. '/Documents/Org/Notes',
	['work_agenda'] = home_dir .. '/Documents/Org/Agenda',
}

local function initWorkspaces()
	local base_dir = vim.fn.isdirectory(home_dir .. '/Development/Seccl/') == vim.v.TRUE
			and home_dir .. '/Development/Seccl/'
		or home_dir .. '/Development/'

	-- Using `ls -d */` errors at '*/' as it is treated as a string not a wildcard
	-- It may be possible not to use the `sync` version but plenary's docs aren't terribly clear
	local projects = Job
		:new({
			command = 'exa',
			args = { '-D' },
			cwd = base_dir,
			on_stderr = function(_, err)
				vim.notify(string.format('Unable to create project workspaces: %s', err), 'error')
			end,
		})
		:sync(1000)

	for _, project in ipairs(projects) do
		workspaces = tbl_extend('keep', workspaces, { [project] = base_dir .. project })
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
			mappings = {
			    n = {
			        ['<Leader>q'] = actions.send_selected_to_qflist + actions.open_qflist
			    }
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

    keymap.set('n', '<Leader>bf', function ()
        require("lxs.plugin_settings.telescope").buffers()
    end, { silent = true, desc = 'Telescope Buffers » Find Buffer'})
    keymap.set('n', '<Leader>b/', function ()
        require("lxs.plugin_settings.telescope").curbuf()
    end, { silent = true, desc = 'Telescope Buffers » Find in Current Buffer'})
    keymap.set('n', '<Leader>gb', function ()
        require("lxs.plugin_settings.telescope").git_branches()
    end, { silent = true, desc = 'Telescope Git » Find Branch'})
    keymap.set('n', '<Leader>gf', function ()
        require("lxs.plugin_settings.telescope").git_files()
    end, { silent = true, desc = 'Telescope Git » Find File'})
    keymap.set('n', '<Leader>gs', function ()
        require("lxs.plugin_settings.telescope").git_status()
    end, { silent = true, desc = 'Telescope Git » Find Changed File'})
    keymap.set('n', '<Leader>hz', function ()
        require("lxs.plugin_settings.telescope").frecency()
    end, { silent = true, desc = 'Telescope Frecency'})
    keymap.set('n', '<Leader>ldd', function ()
        require("lxs.plugin_settings.telescope").lsp_document_diagnostics()
    end, { silent = true, desc = 'Telescope LSP » Diagnostics » Document'})
    keymap.set('n', '<Leader>ldw', function ()
        require("lxs.plugin_settings.telescope").lsp_workspace_diagnostics()
    end, { silent = true, desc = 'Telescope LSP » Diagnostics » Workspace'})
    keymap.set('n', '<Leader>lr', function ()
        require("lxs.plugin_settings.telescope").lsp_references()
    end, { silent = true, desc = 'Telescope LSP » References'})
    keymap.set('n', '<Leader>lr', function ()
        require("lxs.plugin_settings.telescope").lsp_references()
    end, { silent = true, desc = 'Telescope LSP » References'})
    keymap.set('n', '<Leader>lsd', function ()
        require("lxs.plugin_settings.telescope").lsp_document_symbols()
    end, { silent = true, desc = 'Telescope LSP » Symbols » Document'})
    keymap.set('n', '<Leader>lsw', function ()
        require("lxs.plugin_settings.telescope").lsp_dynamic_workspace_symbols()
    end, { silent = true, desc = 'Telescope LSP » Symbols » Workspace'})
    keymap.set('n', '<Leader>ps', function ()
        require("lxs.plugin_settings.telescope").project_search()
    end, { silent = true, desc = 'Telescope Project » Search'})
    keymap.set('n', '<Leader>pf', function ()
        require("lxs.plugin_settings.telescope").fd()
    end, { silent = true, desc = 'Telescope Project » `fd` Find'})
    keymap.set('n', '<Leader>vh', function ()
        require("lxs.plugin_settings.telescope").help_tags()
    end, { silent = true, desc = 'Telescope Vim » Find Help Tags'})
    keymap.set('n', '<Leader>vm', function ()
        require("lxs.plugin_settings.telescope").marks()
    end, { silent = true, desc = 'Telescope Vim » Find Marks'})
    keymap.set('n', '<Leader>pf', function ()
        require("lxs.plugin_settings.telescope").fd()
    end, { silent = true, desc = 'Telescope Project » `fd` Find'})
    keymap.set('n', '<Leader>/', function ()
        require("lxs.plugin_settings.telescope").live_grep()
    end, { silent = true, desc = 'Telescope » Live Grep'})
    keymap.set('n', '<Leader>;', function ()
        require("lxs.plugin_settings.telescope").symbols()
    end, { silent = true, desc = 'Telescope » Find Symbols'})
    keymap.set('n', '<Leader><Leader>', function ()
        require("lxs.plugin_settings.telescope").local_file_browser()
    end, { silent = true, desc = 'Telescope » Relative File Browser'})
    keymap.set('n', '<Leader><Tab>', function ()
        require("lxs.plugin_settings.telescope").file_browser()
    end, { silent = true, desc = 'Telescope » Workspace File Browser'})
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

function M.lsp_document_diagnostics()
	local opts = themes.get_ivy({
		bufnr = 0,
	})

	builtin.diagnostics(opts)
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
