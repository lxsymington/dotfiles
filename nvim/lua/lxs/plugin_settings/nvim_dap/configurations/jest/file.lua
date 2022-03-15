return {
	type = "node",
	request = "launch",
	name = "Jest File Tests",
	protocol = "auto",
	program = "${workspaceFolder}/node_modules/.bin/jest",
	sourceMaps = true,
	resolveSourceMapLocations = {
		"${workspaceFolder}/**",
		"${workspaceFolder}/node_modules/@seccl/**",
	},
	args = { "${file}" },
	skipFiles = { "<node_internals>/**", "**/node_modules/**" },
	console = "integratedTerminal",
	internalConsoleOptions = "openOnSessionStart",
	cwd = "${workspaceFolder}/",
}
