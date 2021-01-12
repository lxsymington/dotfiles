return {
    formatCommand = "./node_module/.bin/eslint --fix-dry-run -f json --stdin --stdin-filename ${INPUT}",
    formatStdin = true,
    lintCommand = "./node_module/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true
}
