local vimp = require('vimp')
local telescope_builtin = require('telescope.builtin')

local M = {}

function M.setup()
    -- Git files search
    vimp.nnoremap('<leader>fgf', function()
        telescope_builtin.git_files{}
    end)

    -- Files search
    vimp.nnoremap('<leader>ff', function()
        telescope_builtin.find_files{}
    end)

    -- LSP references
    vimp.nnoremap('<leader>flr', function()
        telescope_builtin.lsp_references{}
    end)
end

return M
