local vimp = require('vimp')
local M = {}

-- VIM TEST ----------------------------
function M.setup()
    vim.g['test#strategy'] = 'dispatch'

    vimp.nnoremap({'silent'}, '<Leader>tn',
                  function() vim.cmd('TestNearest') end)

    vimp.nnoremap({'silent'}, '<Leader>tf', function() vim.cmd('TestFile') end)

    vimp.nnoremap({'silent'}, '<Leader>ts', function() vim.cmd('TestSuite') end)

    vimp.nnoremap({'silent'}, '<Leader>tl', function() vim.cmd('TestLast') end)

    vimp.nnoremap({'silent'}, '<Leader>tv', function() vim.cmd('TestVisit') end)
end

return M
