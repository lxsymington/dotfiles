local dap = require('dap')
local dap_virtual_text = require('nvim-dap-virtual-text')
local dapui = require('dapui')
local keymap = vim.keymap
local notify_utils = require('lxs.plugin_settings.notify').utilities
local mochaConfigurator = require('lxs.plugin_settings.nvim_dap.configurations.mocha.configurator')
local api = vim.api
local keymap_restore = {}
local M = {}

-- DAP ---------------------------------
function M.setup()
	dap.defaults.fallback.terminal_win_cmd = '80vsplit new'
	--[[ dap.defaults.fallback.external_terminal = {
		command = 'tmux',
		args = {
			'split-window',
			'-h',
			'-l',
			'80',
		},
	} --]]

	dap.listeners.before['event_progressStart']['progress-notifications'] = function(session, body)
		local notif_data = notify_utils.get_notif_data('dap', body.progressId)

		local message = notify_utils.format_message(body.message, body.percentage)
		notif_data.notification = vim.notify(message, 'info', {
			title = notify_utils.format_title(body.title, session.config.type),
			icon = notify_utils.spinner_frames[1],
			timeout = false,
			hide_from_history = false,
		})

		notif_data.notification.spinner = 1, notify_utils.update_spinner('dap', body.progressId)
	end

	dap.listeners.before['event_progressUpdate']['progress-notifications'] = function(session, body)
		local notif_data = notify_utils.get_notif_data('dap', body.progressId)
		notif_data.notification = vim.notify(
			notify_utils.format_message(body.message, body.percentage),
			'info',
			{
				replace = notif_data.notification,
				hide_from_history = false,
			}
		)
	end

	dap.listeners.before['event_progressEnd']['progress-notifications'] = function(session, body)
		local notif_data = notify_utils.client_notifs['dap'][body.progressId]
		notif_data.notification = vim.notify(
			body.message and notify_utils.format_message(body.message) or 'Complete',
			'info',
			{
				icon = '',
				replace = notif_data.notification,
				timeout = 3000,
			}
		)
		notif_data.spinner = nil
	end

	dap.listeners.after['event_initialized']['me'] = function()
		for _, bufnr in pairs(api.nvim_list_bufs()) do
			local keymaps = api.nvim_buf_get_keymap(bufnr, 'n')
			for _, kmap in pairs(keymaps) do
				if kmap.lhs == 'K' then
					table.insert(keymap_restore, kmap)
					keymap.del('n', 'K', { buffer = bufnr })
				end
			end
		end

		keymap.set('n', 'K', function()
			require('dap.ui.variables').hover()
		end, {
			silent = true,
			desc = 'DAP » Hover',
		})
	end

	dap.listeners.after['event_terminated']['me'] = function()
		for _, kmap in pairs(keymap_restore) do
			keymap.set(kmap.mode, kmap.lhs, kmap.rhs, {
				buffer = kmap.buffer,
				silent = kmap.silent == 1,
			})
		end
		keymap_restore = {}
	end

	dap.listeners.before['event_stopped']['dapui'] = function()
		dapui.open()
	end

	dap.listeners.before['event_terminated']['dapui'] = function()
		dapui.close()
	end

	dap.listeners.before['event_exited']['dapui'] = function()
		dapui.close()
	end

	-- Node debugger
	dap.adapters.node = require('lxs.plugin_settings.nvim_dap.adapters.node')
	dap.configurations.node = {
		mochaConfigurator({
			title = 'Mocha JS Test File',
		}),
		mochaConfigurator({
			title = 'Mocha JS Test Workspace',
			glob = 'src/**/*.test.js',
		}),
		mochaConfigurator({
			title = 'Mocha JS Test File | Src Directory | Test Environment',
			environment = 'src/testEnvironment.js',
		}),
		mochaConfigurator({
			title = 'Mocha JS Test Workspace | Src Directory | Test Environment',
			environment = 'src/testEnvironment.js',
			glob = 'src/**/*.test.js',
		}),
		mochaConfigurator({
			title = 'Mocha JS Test File | Test Directory | Test Environment',
			environment = 'test/testEnvironment.js',
		}),
		mochaConfigurator({
			title = 'Mocha JS Test Workspace | Test Directory | Test Environment',
			environment = 'test/testEnvironment.js',
			glob = 'test/**/*.test.js',
		}),
		require('lxs.plugin_settings.nvim_dap.configurations.jest.workspace'),
		require('lxs.plugin_settings.nvim_dap.configurations.jest.file'),
	}
	dap.configurations.typescript = {
		mochaConfigurator({
			title = 'Mocha TS Test File',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test Workspace',
			glob = '**/*.test.ts',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test File | Src Directory | Test Environment',
			environment = 'src/testEnvironment.ts',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test Workspace | Src Directory | Test Environment',
			environment = 'src/testEnvironment.ts',
			glob = 'src/**/*.test.ts',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test File | Test Directory | Test Environment',
			environment = 'test/testEnvironment.ts',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test Workspace | Test Directory | Test Environment',
			environment = 'test/testEnvironment.ts',
			glob = 'test/**/*.test.ts',
			typescript = true,
		}),
		require('lxs.plugin_settings.nvim_dap.configurations.jest.workspace'),
		require('lxs.plugin_settings.nvim_dap.configurations.jest.file'),
	}

	-- Allow `nvim-dap` to attempt to load settings from VSCode's launch.json
	vim.cmd([[command! DebugLoadLaunchJS lua require('dap.ext.vscode').load_launchjs()]])

	keymap.set('n', '<Leader>D=', function()
		require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
	end, {
		desc = 'DAP » Toggle Log Point',
		silent = true,
	})
	keymap.set('n', '<Leader>D?', function()
		require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
	end, {
		desc = 'DAP » Toggle Conditional Breakpoint',
		silent = true,
	})
	keymap.set('n', '<Leader>Db', function()
		require('dap').toggle_breakpoint()
	end, {
		desc = 'DAP » Toggle Breakpoint',
		silent = true,
	})
	keymap.set('n', '<Leader>Dc', function()
		require('dap').continue()
	end, {
		desc = 'DAP » Launch/Continue',
		silent = true,
	})
	keymap.set('n', '<Leader>Di', function()
		require('dap').step_into()
	end, {
		desc = 'DAP » Step Into',
		silent = true,
	})
	keymap.set('n', '<Leader>Dl', function()
		require('dap').run_last()
	end, {
		desc = 'DAP » Re-run Last Session',
		silent = true,
	})
	keymap.set('n', '<Leader>Do', function()
		require('dap').step_out()
	end, {
		desc = 'DAP » Step Out',
		silent = true,
	})
	keymap.set('n', '<Leader>Dr', function()
		require('dap').repl.open()
	end, {
		desc = 'DAP » Open REPL',
		silent = true,
	})
	keymap.set('n', '<Leader>Ds', function()
		require('dap').step_over({})
	end, {
		desc = 'DAP » Step Over',
		silent = true,
	})
	-- Set up mappings for `nvim-dap`

	-- Signs
	vim.fn.sign_define('DapBreakpoint', { text = 'ﱏ', texthl = 'Normal' })
	vim.fn.sign_define('DapBreakpointCondition', { text = '﯆', texthl = 'Conditional' })
	vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Todo' })
	vim.fn.sign_define('DapStopped', { text = '', texthl = 'WarningMsg' })
	vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'Error' })

	-- Show virtual text for current frame
	dap_virtual_text.setup()
end

return M
