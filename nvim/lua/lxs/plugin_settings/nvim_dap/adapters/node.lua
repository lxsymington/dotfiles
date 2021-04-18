return {
	type = "executable",
	command = os.getenv("NVM_BIN") .. "/node",
	args = {
		os.getenv("HOME") .. "/Tools/vscode-node-debug2/out/src/nodeDebug.js",
	},
}
