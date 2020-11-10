local vimp = require('vimp')
local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')
local completion = require('completion')
local diagnostic = require('diagnostic')

-- Turn on status.
lsp_status.register_progress()

local custom_attach = function(client)
    completion.on_attach(client)
    diagnostic.on_attach(client)
    lsp_status.on_attach(client)

    -- Go to definition
    vimp.nnoremap({'silent'}, '<Leader>gd', function()
        vim.lsp.buf.definition()
    end)

    -- Go to implementation
    vimp.nnoremap({'silent'}, '<Leader>gi', function()
        vim.lsp.buf.implementation()
    end)

    -- Go to type definition
    vimp.nnoremap({'silent'}, '<Leader>gtd', function()
        vim.lsp.buf.type_definition()
    end)

    -- Go to references
    vimp.nnoremap({'silent'}, '<Leader>gr', function()
        vim.lsp.buf.references()
    end)

    -- Code action
    vimp.nnoremap({'silent'}, '<Leader>ca', function()
        vim.lsp.buf.code_action()
    end)

    -- Rename
    vimp.nnoremap({'silent'}, '<Leader>r', function()
        vim.lsp.buf.rename()
    end)

    -- Hover
    vimp.nnoremap({'silent'}, 'K', function()
        vim.lsp.buf.hover()
    end)

    -- Show line diagnostics
    vimp.nnoremap({'silent'}, '<Leader>-', function()
        vim.lsp.util.show_line_diagnostics()
    end)

    -- Signature help
    vimp.nnoremap({'silent'}, '<Leader>sh', function()
        vim.lsp.buf.signature_help()
    end)

    -- Go to next diagnostic
    vimp.nnoremap({'silent'}, ']d', function()
        vim.lsp.structures.Diagnostic.buf_move_next_diagnostic()
    end)

    -- Go to previous diagnostic
    vimp.nnoremap({'silent'}, '[d', function()
        vim.lsp.structures.Diagnostic.buf_move_prev_diagnostic()
    end)

    -- Rust is currently the only thing w/ inlay hints
    if vim.api.nvim_buf_get_option(0, 'filetype') == 'rust' then
        vim.cmd [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { aligned = true, prefix = " » " }]]
    end

    vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
end

nvim_lsp.cssls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.html.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.jsonls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.rust_analyzer.setup({
    cmd = {"rust-analyzer"},
    filetypes = {"rust"},
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.sumneko_lua.setup({
    cmd = { "/home/lxs/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/lxs/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
    on_attach=on_attach_vim,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.tsserver.setup({
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    },
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.vimls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

nvim_lsp.yamlls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})
