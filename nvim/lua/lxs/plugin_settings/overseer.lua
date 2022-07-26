local overseer = require('overseer')
local keymap = vim.keymap
local M ={}

function M.setup()
    overseer.setup()

    keymap.set('n', '<Leader>Ot', vim.cmd.OverseerToggle, {
        desc = 'Overseer » Toggle',
        silent = true
    })
    keymap.set('n', '<Leader>Ob', vim.cmd.OverseerBuild, {
        desc = 'Overseer » Builder',
        silent = true
    })
    keymap.set('n', '<Leader>Oa', vim.cmd.OverseerTaskAction, {
        desc = 'Overseer » Run Action',
        silent = true
    })
    keymap.set('n', '<Leader>Or', vim.cmd.OverseerRun, {
        desc = 'Overseer » Run Action',
        silent = true
    })
end

return M
