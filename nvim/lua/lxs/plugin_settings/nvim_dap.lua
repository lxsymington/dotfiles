local dap = require('dap')
local dap_virtual_text = require('nvim-dap-virtual-text')
local wk = require('which-key')
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

	dap.listeners.after['event_initialized']['me'] = function()
		for _, buf in pairs(api.nvim_list_bufs()) do
			local keymaps = api.nvim_buf_get_keymap(buf, 'n')
			for _, kmap in pairs(keymaps) do
				if kmap.lhs == 'K' then
					table.insert(keymap_restore, kmap)
					api.nvim_buf_del_keymap(buf, 'n', 'K')
				end
			end
		end

		wk.register({
			K = {
				'<Cmd>lua require("dap.ui.variables").hover()<CR>',
				'DAP hover',
			},
		}, {
			mode = 'n',
			silent = true,
		})
	end

	dap.listeners.after['event_terminated']['me'] = function()
		for _, kmap in pairs(keymap_restore) do
			api.nvim_buf_set_keymap(
				kmap.buffer,
				kmap.mode,
				kmap.lhs,
				kmap.rhs,
				{ silent = kmap.silent == 1 }
			)
		end
		keymap_restore = {}
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
			environment = 'src/testEnvironment.js',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test Workspace | Src Directory | Test Environment',
			environment = 'src/testEnvironment.js',
			glob = 'src/**/*.test.ts',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test File | Test Directory | Test Environment',
			environment = 'test/testEnvironment.js',
			typescript = true,
		}),
		mochaConfigurator({
			title = 'Mocha TS Test Workspace | Test Directory | Test Environment',
			environment = 'test/testEnvironment.js',
			glob = 'test/**/*.test.ts',
			typescript = true,
		}),
		require('lxs.plugin_settings.nvim_dap.configurations.jest.workspace'),
		require('lxs.plugin_settings.nvim_dap.configurations.jest.file'),
	}

	-- Allow `nvim-dap` to attempt to load settings from VSCode's launch.json
	vim.cmd([[command! DebugLoadLaunchJS lua require('dap.ext.vscode').load_launchjs()]])

	-- Set up mappings for `nvim-dap`
	wk.register({
		['<Leader>D'] = {
			name = 'DAP',
			['='] = {
				'<Cmd>:lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
				'toggle log point',
			},
			['?'] = {
				'<Cmd>:lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
				'toggle conditional breakpoint',
			},
			b = {
				'<Cmd>:lua require("dap").toggle_breakpoint()<CR>',
				'toggle breakpoint',
			},
			c = {
				'<Cmd>:lua require("dap").continue()<CR>',
				'launch/continue',
			},
			i = {
				'<Cmd>:lua require("dap").step_into()<CR>',
				'step into',
			},
			l = {
				'<Cmd>:lua require("dap").run_last()<CR>',
				're-run last session',
			},
			o = {
				'<Cmd>:lua require("dap").step_out()<CR>',
				'step out',
			},
			r = {
				'<Cmd>:lua require("dap").repl.open()<CR>',
				'open REPL',
			},
			s = {
				'<Cmd>:lua require("dap").step_over()<CR>',
				'step over',
			},
		},
	}, {
		mode = 'n',
		noremap = true,
		silent = true,
	})

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
