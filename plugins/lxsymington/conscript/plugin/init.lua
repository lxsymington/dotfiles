local conscript = require('conscript')
local M         = {}

--[[
 TODO:
 - locate a package.json in the `pwd` or ancestors
    - check if there is some better way of doing this via the LSP
 - parse the package.json to find any `scripts`
 - if there are scripts load the rest of the plugin
]]

function M.enroll()
    local conscript_augroup = vim.api.nvim_create_augroup('ConscriptEnroll', { clear = true })

    vim.api.nvim_create_autocmd({
        'VimEnter',
        'SessionLoadPost',
        'DirChanged'
    },
        {
        pattern = '*',
        callback = conscript.scout,
        group = conscript_augroup
    })
end

M.enroll()

return M
