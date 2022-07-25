local conscript           = require('conscript')
local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd
local M                   = {}

function M.enroll()
    local conscript_augroup = nvim_create_augroup('ConscriptEnroll', { clear = true })

    nvim_create_autocmd({
        'VimEnter',
        'SessionLoadPost',
        'DirChanged'
    },
        {
            pattern = '*',
            callback = conscript.scout,
            group = conscript_augroup,
            once = true
        })
end

M.enroll()

return M
