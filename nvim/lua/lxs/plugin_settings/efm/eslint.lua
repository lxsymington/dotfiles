return {
    formatCommand = "eslintme --fix-to-stdout --stdin --stdin-filename ${INPUT}",
    formatStdin = true,
    lintCommand = "eslintme -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'}
}
