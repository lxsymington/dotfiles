return {
	type = 'executable',
	command = os.getenv('VOLTA_HOME') .. '/bin/node',
	args = {
		os.getenv('HOME') .. '/Tools/vscode-node-debug2/out/src/nodeDebug.js',
	},
}
