local dap = require("dap")
local mochaConfigurator = require("lxs.plugin_settings.nvim_dap.configurations.mocha.configurator")
local keymap = vim.api.nvim_set_keymap
local M = {}
local api = vim.api
local keymap_restore = {}

dap.listeners.after["event_initialized"]["me"] = function()
	for _, buf in pairs(api.nvim_list_bufs()) do
		local keymaps = api.nvim_buf_get_keymap(buf, "n")
		for _, keymap in pairs(keymaps) do
			if keymap.lhs == "K" then
				table.insert(keymap_restore, keymap)
				api.nvim_buf_del_keymap(buf, "n", "K")
			end
		end
	end
	api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.variables").hover()<CR>', { silent = true })
end

dap.listeners.after["event_terminated"]["me"] = function()
	for _, keymap in pairs(keymap_restore) do
		api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
	end
	keymap_restore = {}
end

-- DAP ---------------------------------
function M.setup()
	-- Node debugger
	dap.adapters.node = require("lxs.plugin_settings.nvim_dap.adapters.node")
	dap.configurations.node = {
		mochaConfigurator({
			title = "Mocha JS Test File",
		}),
		mochaConfigurator({
			title = "Mocha JS Test Workspace",
			glob = "src/**/*.test.js",
		}),
		mochaConfigurator({
			title = "Mocha JS Test File | Src Directory | Test Environment",
			environment = "src/testEnvironment.js",
		}),
		mochaConfigurator({
			title = "Mocha JS Test Workspace | Src Directory | Test Environment",
			environment = "src/testEnvironment.js",
			glob = "src/**/*.test.js",
		}),
		mochaConfigurator({
			title = "Mocha JS Test File | Test Directory | Test Environment",
			environment = "test/testEnvironment.js",
		}),
		mochaConfigurator({
			title = "Mocha JS Test Workspace | Test Directory | Test Environment",
			environment = "test/testEnvironment.js",
			glob = "test/**/*.test.js",
		}),
		require("lxs.plugin_settings.nvim_dap.configurations.jest.workspace"),
		require("lxs.plugin_settings.nvim_dap.configurations.jest.file"),
	}
	dap.configurations.typescript = {
		mochaConfigurator({
			title = "Mocha TS Test File",
			typescript = true,
		}),
		mochaConfigurator({
			title = "Mocha TS Test Workspace",
			glob = "**/*.test.ts",
			typescript = true,
		}),
		mochaConfigurator({
			title = "Mocha TS Test File | Src Directory | Test Environment",
			environment = "src/testEnvironment.js",
			typescript = true,
		}),
		mochaConfigurator({
			title = "Mocha TS Test Workspace | Src Directory | Test Environment",
			environment = "src/testEnvironment.js",
			glob = "src/**/*.test.ts",
			typescript = true,
		}),
		mochaConfigurator({
			title = "Mocha TS Test File | Test Directory | Test Environment",
			environment = "test/testEnvironment.js",
			typescript = true,
		}),
		mochaConfigurator({
			title = "Mocha TS Test Workspace | Test Directory | Test Environment",
			environment = "test/testEnvironment.js",
			glob = "test/**/*.test.ts",
			typescript = true,
		}),
		require("lxs.plugin_settings.nvim_dap.configurations.jest.workspace"),
		require("lxs.plugin_settings.nvim_dap.configurations.jest.file"),
	}

	-- Allow `nvim-dap` to attempt to load settings from VSCode's launch.json
	vim.cmd([[command! DebugLoadLaunchJS lua require('dap.ext.vscode').load_launchjs()]])

	-- Set up mappings for `nvim-dap`
	-- CONTINUE
	keymap("n", "<F5>", "<Cmd>:lua require('dap').continue()<CR>", { noremap = true, silent = true })
	-- STEP OVER
	keymap("n", "<F10>", "<Cmd>:lua require('dap').step_over()<CR>", { noremap = true, silent = true })
	-- STEP INTO
	keymap("n", "<F11>", "<Cmd>:lua require('dap').step_into()<CR>", { noremap = true, silent = true })
	-- STEP OUT
	keymap("n", "<F12>", "<Cmd>:lua require('dap').step_out()<CR>", { noremap = true, silent = true })
	-- TOGGLE BREAKPOINT
	keymap("n", "<Leader>b", "<Cmd>:lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true })
	-- SET CONDITIONAL BREAKPOINT
	keymap(
		"n",
		"<Leader>B",
		"<Cmd>:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		{ noremap = true, silent = true }
	)
	-- SET LOGPOINT
	keymap("n", "<Leader>lp", "<Cmd>:lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", {
		noremap = true,
		silent = true,
	})
	-- OPEN DEBUGGER CONSOLE
	keymap("n", "<Leader>dr", "<Cmd>:lua require('dap').repl.open()<CR>", { noremap = true, silent = true })
	-- RE-RUN LAST DEBUGGING SESSION
	keymap("n", "<Leader>dl", "<Cmd>:lua require('dap').run_last()<CR>", { noremap = true, silent = true })

	-- Show virtual text for current frame
	vim.g.dap_virtual_text = true
end

return M
