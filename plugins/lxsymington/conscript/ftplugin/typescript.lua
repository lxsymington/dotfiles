local M = {}

--[[
 TODO:
 - Luasnips for typescript if available
 - makeprg to use npm
 - parse the selected build command and use an appropriate errorformat
 - See https://www.reddit.com/r/vim/comments/ibo5e1/sharing_some_errorformats/
]]

local typescript_error = [[%E%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m]]
local typescript_warning = [[\%W%f\ %#(%l\\,%c):\ %tarning\ TS%n:\ %m]]

function M.setup()
    vim.opt_local.makeprg = 'npm run'

    vim.opt_local.errorformat = {
        typescript_error,
        typescript_warning,
    }
end

M.setup()

return M
