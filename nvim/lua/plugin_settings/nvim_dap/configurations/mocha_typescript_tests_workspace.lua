return {
    type = "node",
    request = "launch",
    name = "Mocha TypeScript Workspace Tests",
    protocol = "auto",
    program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
    args = {
        "-u", "bdd", "--require", "ts-node/register", "--timeout", "3000",
        "--colors", "${workspaceFolder}/test/**/*.test.ts"
    },
    skipFiles = {"<node_internals>/**"},
    console = "integratedTerminal",
    internalConsoleOptions = "openOnSessionStart",
    cwd = "${workspaceFolder}/"
}
