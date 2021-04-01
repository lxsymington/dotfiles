return {
    type = "node",
    request = "launch",
    name = "Jest File Tests",
    protocol = "auto",
    program = "${workspaceFolder}/node_modules/.bin/jest",
    args = {"${file}"},
    skipFiles = {"<node_internals>/**"},
    console = "integratedTerminal",
    internalConsoleOptions = "openOnSessionStart",
    cwd = "${workspaceFolder}/"
}
