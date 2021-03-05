return {
    type = "node",
    request = "launch",
    name = "Mocha TypeScript With Test Environment File Tests",
    protocol = "auto",
    program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
    args = {
        "-u", "bdd", "--require", "ts-node/register", "--require",
        "./test/testEnvironment.ts", "--timeout", "3000", "--colors", "${file}"
    },
    skipFiles = {"<node_internals>/**"},
    console = "integratedTerminal",
    internalConsoleOptions = "openOnSessionStart",
    cwd = "${workspaceFolder}/"
}
