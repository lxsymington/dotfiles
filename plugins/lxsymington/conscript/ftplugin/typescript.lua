local M = {}

--[[
 TODO:
 - Luasnips for typescript if available
 - makeprg to use npm
 - parse the selected build command and use an appropriate errorformat
 - See https://www.reddit.com/r/vim/comments/ibo5e1/sharing_some_errorformats/
]]

function M.setup()
    vim.opt_local.makeprg = 'npm run'

    vim.opt_local.errorformat = {
        [[%E%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m]],
        [[\%W%f\ %#(%l\\,%c):\ %tarning\ TS%n:\ %m]],
    }
end

M.setup()

return M
