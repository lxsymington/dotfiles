local keymap = vim.keymap
local M = {}

-- LSP Keymaps -------------------------
---@param bufnr buffer number (number)
function M.setup(bufnr)
    keymap.set('n', '<Leader>-', vim.diagnostic.setloclist, {
		buffer = bufnr,
        desc = 'LSP » Add buffer diagnostics to the location list',
        silent = true
    })
    keymap.set('n', '<Leader>@', '<Cmd>:PeekDefinition<CR>', {
		buffer = bufnr,
        desc = 'LSP » Peek Definition',
        silent = true
    })
    keymap.set('n', '<Leader>aas', vim.lsp.buf.code_action, {
		buffer = bufnr,
        desc = 'LSP » Analysis » Actions » Single',
        silent = true
    })
    keymap.set('n', '<Leader>aar', vim.lsp.buf.range_code_action, {
		buffer = bufnr,
        desc = 'LSP » Analysis » Actions » Range',
        silent = true
    })
    keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, {
		buffer = bufnr,
        desc = 'LSP » Go To » Definition',
        silent = true
    })
    keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, {
		buffer = bufnr,
        desc = 'LSP » Go To » Implementation',
        silent = true
    })
    keymap.set('n', '<Leader>gr', vim.lsp.buf.references, {
		buffer = bufnr,
        desc = 'LSP » Go To » References',
        silent = true
    })
    keymap.set('n', '<Leader>gt', vim.lsp.buf.type_definition, {
		buffer = bufnr,
        desc = 'LSP » Go To » Type Definition',
        silent = true
    })
    keymap.set('n', '<Leader>r', vim.lsp.buf.rename, {
		buffer = bufnr,
        desc = 'LSP » Rename',
        silent = true
    })
    keymap.set('n', '<Leader>sh', vim.lsp.buf.signature_help, {
		buffer = bufnr,
        desc = 'LSP » Signature Help',
        silent = true
    })
    keymap.set('n', '<Leader>wd', vim.lsp.buf.signature_help, {
		buffer = bufnr,
        desc = 'LSP » Signature Help',
        silent = true
    })
    keymap.set('n', '<Leader>wd', function ()
        require('lsp_extensions.workspace.diagnostic').set_qf_list()
    end, { buffer = bufnr, desc = 'LSP » Workspace Diagnostics', silent = true })
    keymap.set('n', 'K', vim.lsp.buf.hover, {
		buffer = bufnr,
        desc = 'LSP » Hover',
        silent = true
    })
    keymap.set('n', '[d', function ()
        vim.diagnostic.goto_prev({ float = { border = 'rounded', source = 'if_many' } })
    end, { buffer = bufnr, desc = 'LSP » Previous Diagnostic', silent = true })
    keymap.set('n', ']d', function ()
        vim.diagnostic.goto_next({ float = { border = 'rounded', source = 'if_many' } })
    end, { buffer = bufnr, desc = 'LSP » Previous Diagnostic', silent = true })
end

return M
