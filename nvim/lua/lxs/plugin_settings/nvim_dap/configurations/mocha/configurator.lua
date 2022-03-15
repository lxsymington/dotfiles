local function mochaConfigurator(config)
	local args = { "-u", "bdd", "--timeout", "3000", "--colors" }

	if config.typescript then
		for _, arg in pairs({ "--require", "ts-node/register" }) do
			table.insert(args, arg)
		end
	end

	if config.environment then
		for _, arg in pairs({ "--require", config.environment }) do
			table.insert(args, arg)
		end
	end

	table.insert(args, config.glob and "${workspaceFolder}/" .. config.glob or "${file}")

	return {
		type = "node",
		request = "launch",
		name = config.title,
		protocol = "auto",
		program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
		sourceMaps = true,
		resolveSourceMapLocations = {
			"${workspaceFolder}/**",
			"${workspaceFolder}/node_modules/@seccl/**",
		},
		args = args,
		skipFiles = { "<node_internals>/**", "**/node_modules/**" },
		console = "integratedTerminal",
		internalConsoleOptions = "openOnSessionStart",
		cwd = "${workspaceFolder}/",
	}
end

return mochaConfigurator
