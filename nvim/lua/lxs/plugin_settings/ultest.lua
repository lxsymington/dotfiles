local ultest = require('ultest')
local session_augroups = require('lxs.autocommands').session_augroups
local base_config = require('lxs.plugin_settings.nvim_dap.configurations.base')
local keymap = vim.keymap
local api = vim.api
local g = vim.g
local M = {}

local debug_config = function(cmd)
	local program = table.remove(cmd, 1)

	local dap_program = ''
	if string.match(program, '^/') then
		dap_program = program
	elseif string.match(program, '^%./') then
		dap_program = string.gsub(program, '^%./', '${workspaceFolder}/')
	else
		dap_program = string.format('${workspaceFolder}/%s', program)
	end

	return {
		dap = vim.tbl_extend('force', base_config, {
			name = 'Ultest debug',
			program = dap_program,
			args = cmd,
		}),
	}
end

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
			['javascript#jest'] = debug_config,
			['javascriptreact#jest'] = debug_config,
			['javascript#mocha'] = debug_config,
			['javascriptreact#mocha'] = debug_config,
			['typescript#jest'] = debug_config,
			['typescriptreact#jest'] = debug_config,
			['typescript#mocha'] = debug_config,
			['typescriptreact#mocha'] = debug_config,
		},
	})

	local ultest_group = session_augroups('UltestRunner')
	api.nvim_create_autocmd(
		'BufWritePost',
		{ pattern = '*', command = 'UltestNearest', group = ultest_group }
	)

	keymap.set('n', ']t', '<Plug>(ultest-next-fail)', {
		desc = 'Next » Failing Test',
		silent = true,
	})
	keymap.set('n', '[t', '<Plug>(ultest-prev-fail)', {
		desc = 'Previous » Failing Test',
		silent = true,
	})
end

return M
