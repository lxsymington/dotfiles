local vimp = require('vimp')
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local completion = require('completion')

-- Turn on status.
lsp_status.register_progress()

local custom_attach = function(client)
    completion.on_attach(client)
    lsp_status.on_attach(client)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- Enable underline, use default values
            underline = true,
            -- Enable virtual text, override spacing to 4
            virtual_text = {
                spacing = 4,
                prefix = '🔎',
            },
        }
    )

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

    -- Open diagnostics
    vimp.nnoremap({'silent'}, '<Leader>-', function()
        vim.lsp.diagnostic.set_loclist()
    end)

    -- Signature help
    vimp.nnoremap({'silent'}, '<Leader>sh', function()
        vim.lsp.buf.signature_help()
    end)

    -- Go to next diagnostic
    vimp.nnoremap({'silent'}, ']d', function()
        vim.lsp.diagnostic.goto_next()
    end)

    -- Go to previous diagnostic
    vimp.nnoremap({'silent'}, '[d', function()
        vim.lsp.diagnostic.goto_prev()
    end)

    -- Rust is currently the only thing w/ inlay hints
    if vim.api.nvim_buf_get_option(0, 'filetype') == 'rust' then
        vim.cmd [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { aligned = true, prefix = " » " }]]
    end

    vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
end

lspconfig.cssls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.efm.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.html.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.jsonls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.rust_analyzer.setup({
    cmd = {"rust-analyzer"},
    filetypes = {"rust"},
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.sumneko_lua.setup({
    cmd = { "/home/lxs/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/lxs/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/main.lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ';'),
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
            diagnostics = {
                globals = {"vim"},
                disable = {"lowercase-global", "unused-function"}
            },
            completion = {
                keywordSnippet = "Disable",
            },
        },
    },
    on_attach=custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.tsserver.setup({
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

lspconfig.vimls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})

lspconfig.yamlls.setup({
    on_attach = custom_attach,
    capabilities = lsp_status.capabilities,
})
