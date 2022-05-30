local ultest = require('ultest')
local wk = require('which-key')
local session_augroups = require('lxs.autocommands').session_augroups
local dap_jest_file_config = require('lxs.plugin_settings.nvim_dap.configurations.jest.file')
local dap_mocha_configurator = require(
	'lxs.plugin_settings.nvim_dap.configurations.mocha.configurator'
)
local api = vim.api
local g = vim.g
local M = {}

-- Ultest ------------------------------
function M.setup()
	g.ultest_max_threads = 4
	g.ultest_use_pty = 1
	g.ultest_virtual_text = 1
	g.ultest_pass_sign = ''
	g.ultest_fail_sign = '﮻'
	g.ultest_running_sign = ''
	g.ultest_not_run_sign = ''
	g.ultest_pass_text = ''
	g.ultest_fail_text = '﮻'
	g.ultest_running_text = ''

	ultest.setup({
		builders = {
			['javascript#jest'] = function(cmd)
				print('javascript#jest')
				vim.pretty_print(cmd)
				return {
					dap = dap_jest_file_config,
				}
			end,
			['javascriptreact#jest'] = function(cmd)
				print('javascriptreact#jest')
				vim.pretty_print(cmd)
				return {
					dap = dap_jest_file_config,
				}
			end,
			['javascript#mocha'] = function(cmd)
				print('javascript#mocha')
				vim.pretty_print(cmd)
				return {
					dap = dap_mocha_configurator({
						title = 'Mocha JS Test File',
					}),
				}
			end,
			['javascriptreact#mocha'] = function(cmd)
				print('javascriptreact#mocha')
				vim.pretty_print(cmd)
				return {
					dap = dap_mocha_configurator({
						title = 'Mocha JS Test File',
					}),
				}
			end,
			['typescript#jest'] = function(cmd)
				print('typescript#jest')
				vim.pretty_print(cmd)
				return {
					dap = dap_jest_file_config,
				}
			end,
			['typescriptreact#jest'] = function(cmd)
				print('typescriptreact#jest')
				vim.pretty_print(cmd)
				return {
					dap = dap_jest_file_config,
				}
			end,
			['typescript#mocha'] = function(cmd)
				print('typescript#mocha')
				vim.pretty_print(cmd)
				return {
					dap = dap_mocha_configurator({
						title = 'Mocha JS Test File',
						typescript = true,
					}),
				}
			end,
			['typescriptreact#mocha'] = function(cmd)
				print('typescriptreact#mocha')
				vim.pretty_print(cmd)
				return {
					dap = dap_mocha_configurator({
						title = 'Mocha JS Test File',
						typescript = true,
					}),
				}
			end,
		},
	})

	local ultest_group = session_augroups('UltestRunner')
	api.nvim_create_autocmd(
		'BufWritePost',
		{ pattern = '*', command = 'UltestNearest', group = ultest_group }
	)

	wk.register({
		[']'] = {
			name = 'Next',
			t = {
				'<Plug>(ultest-next-fail)',
				'failing test',
			},
		},
		['['] = {
			name = 'Previous',
			t = {
				'<Plug>(ultest-prev-fail)',
				'failing test',
			},
		},
	}, {
		mode = 'n',
		noremap = true,
		silent = true,
	})
end

return M
