return {
    formatCommand = "eslint_d --cache --fix-to-stdout -f unix --stdin --stdin-filename ${INPUT}",
    formatStdin = true,
    lintCommand = "eslint_d --cache -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'}
}
