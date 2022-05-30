return {
	type = 'node',
	request = 'launch',
	protocol = 'auto',
	sourceMaps = true,
	resolveSourceMapLocations = {
		'${workspaceFolder}/**',
		'${workspaceFolder}/node_modules/@seccl/**',
	},
	skipFiles = { '<node_internals>/**', '**/node_modules/**' },
	console = 'integratedTerminal',
	internalConsoleOptions = 'openOnSessionStart',
	cwd = '${workspaceFolder}/',
}
