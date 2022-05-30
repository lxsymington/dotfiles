local base_config = require('lxs.plugin_settings.nvim_dap.configurations.base')
return vim.tbl_extend('force', base_config, {
	name = 'Jest Workspace Tests',
	program = '${workspaceFolder}/node_modules/.bin/jest',
})
