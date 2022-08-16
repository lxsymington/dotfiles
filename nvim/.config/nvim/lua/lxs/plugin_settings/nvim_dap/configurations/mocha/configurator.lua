local base_config = require('lxs.plugin_settings.nvim_dap.configurations.base')

local function mochaConfigurator(config)
	local args = { '-u', 'bdd', '--timeout', '3000', '--colors' }

	if config.typescript then
		for _, arg in pairs({ '--require', 'ts-node/register' }) do
			table.insert(args, arg)
		end
	end

	if config.environment then
		for _, arg in pairs({ '--require', config.environment }) do
			table.insert(args, arg)
		end
	end

	table.insert(args, config.glob and '${workspaceFolder}/' .. config.glob or '${file}')

	return vim.tbl_extend('force', base_config, {
		name = config.title,
		program = '${workspaceFolder}/node_modules/mocha/bin/_mocha',
		args = args,
	})
end

return mochaConfigurator
