return {
    formatCommand = "./node_modules/.bin/eslint --fix-dry-run -f json --stdin --stdin-filename ${INPUT}",
    formatStdin = true,
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true
}
