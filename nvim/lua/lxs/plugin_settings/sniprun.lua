local keymap = vim.api.nvim_set_keymap
local M = {}

-- Sniprun -----------------------------
function M.setup()
    require('sniprun').setup({
        display = { 'NvimNotify' },
        show_no_output = { 'NvimNotify' },
        borders = 'rounded'
    })

    local keymap_opts = { noremap = true, silent = true }
    keymap('v', '<Tab>', '<Plug>Sniprun', keymap_opts)
    keymap('n', '<Leader>e', '<Plug>SnipRunOperator', keymap_opts)
    keymap('n', '<Leader>E', '<Plug>Sniprun', keymap_opts)
end

return M
