return {
    type = "node",
    request = "launch",
    name = "Mocha Tests",
    protocol = "auto",
    program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
    args = {"-u", "tdd", "--timeout", "60000", "--colors", "${file}"},
    skipFiles = {"<node_internals>/**"},
    console = "integratedTerminal",
    internalConsoleOptions = "openOnSessionStart",
    cwd = "${workspaceFolder}/"
}