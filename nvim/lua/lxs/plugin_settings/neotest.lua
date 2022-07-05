local neotest = require('neotest')
local neotest_vim_test = require('neotest-vim-test')
local M = {}

function M.setup()
    neotest.setup({
        adapters = {
            neotest_vim_test({
                ignore_file_types = {}
            })
        }
    })
end

return M
