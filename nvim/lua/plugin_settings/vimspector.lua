local M = {}

-- DEPRECATED - USING NVIM-DAP ---------
-- VIMSPECTOR --------------------------
function M.setup()
    vim.g.vimspector_install_gadgets = {'vscode-node-debug2'}
    vim.g.vimspector_enable_mappings = 'HUMAN'
end

return M
