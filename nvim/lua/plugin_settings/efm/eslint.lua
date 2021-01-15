return {
    formatCommand = "eslint_d --fix-to-stdout -f unix --stdin --stdin-filename ${INPUT}",
    formatStdin = true,
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true
}
