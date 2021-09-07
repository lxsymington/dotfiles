return {
	type = 'node',
	request = 'launch',
	name = 'Jest Workspace Tests',
	protocol = 'auto',
	program = '${workspaceFolder}/node_modules/.bin/jest',
	skipFiles = { '<node_internals>/**' },
	console = 'integratedTerminal',
	internalConsoleOptions = 'openOnSessionStart',
	cwd = '${workspaceFolder}/',
}
