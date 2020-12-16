return {
    lintCommand = "./node_module/bin/eslint -c ./package.json --fix -f unix --stdin",
    lintIgnoreExitCode = true,
    lintStdin = true,
}
