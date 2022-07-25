local conscript = require('conscript')
local M         = {}

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
            group = conscript_augroup,
            once = true
        })
end

M.enroll()

return M
