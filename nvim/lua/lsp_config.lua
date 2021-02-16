local vimp = require('vimp')
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local lsp_status = require('lsp-status')
local completion = require('completion')
local vint = require('plugin_settings.efm.vint')
local lua_format = require('plugin_settings.efm.lua-format')
local prettier = require('plugin_settings.efm.prettier')
local eslint = require('plugin_settings.efm.eslint')
local tslint = require('plugin_settings.efm.tslint')
local M = {}

-- Enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

-- Pretty icons
vim.lsp.protocol.CompletionItemKind = {
    " [text]",
    " [method]",
    " [function]",
    " [constructor]",
    "ﰠ [field]",
    " [variable]",
    " [class]",
    " [interface]",
    " [module]",
    " [property]",
    " [unit]",
    " [value]",
    " [enum]",
    " [key]",
    "﬌ [snippet]",
    " [color]",
    " [file]",
    " [reference]",
    " [folder]",
    " [enum member]",
    " [constant]",
    " [struct]",
    "⌘ [event]",
    " [operator]",
    "♛ [type]"
}

-- Formatting
local format_options_prettier = {
    tabWidth = 4,
    singleQuote = true,
    trailingComma = "all",
    configPrecedence = "prefer-file"
}

vim.g.format_options_typescript = format_options_prettier
vim.g.format_options_javascript = format_options_prettier
vim.g.format_options_typescriptreact = format_options_prettier
vim.g.format_options_javascriptreact = format_options_prettier
vim.g.format_options_css = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_markdown = format_options_prettier

function FormatToggle(value)
    vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end

vim.cmd [[command! FormatDisable lua FormatToggle(true)]]
vim.cmd [[command! FormatEnable lua FormatToggle(false)]]

_G.formatting = function()
    if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
        vim.lsp.buf.formatting(vim.g[string.format("format_options_%s",
                                                   vim.bo.filetype)] or {})
    end
end

-- Preview definition
local function preview_location_callback(_, _, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

vim.cmd [[command! PeekDefinition lua PeekDefinition()]]

-- Turn on status.
lsp_status.register_progress()

-- Attach
local custom_attach = function(client)
    completion.on_attach(client)
    lsp_status.on_attach(client)

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> lua formatting()
            augroup END
        ]]
    end

    -- Rust is currently the only thing w/ inlay hints
    if vim.api.nvim_buf_get_option(0, 'filetype') == 'rust' then
        vim.api.nvim_command [[
            augroup InlayHints
            autocmd! * <buffer>
            autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {
                aligned = true,
                prefix = " » "
            }
            augroup END
        ]]
    end

    vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
end

function M.setup()
    -- Set LSP client's log level. Server's log level is not affected.
    vim.lsp.set_log_level('info')

    vim.lsp.handlers["textDocument/formatting"] =
        function(err, _, result, _, bufnr)
            if err ~= nil or result == nil then return end
            if not vim.api.nvim_buf_get_option(bufnr, "modified") then
                local view = vim.fn.winsaveview()
                vim.lsp.util.apply_text_edits(result, bufnr)
                vim.fn.winrestview(view)
                if bufnr == vim.api.nvim_get_current_buf() then
                    vim.api.nvim_command("noautocmd :update")
                end
            end
        end

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            -- Enable underline, use default values
            underline = true,
            -- Enable virtual text, override spacing to 4
            virtual_text = {spacing = 4, prefix = '🔎'}
        })

    --     -- Alloyed Lua Language Server
    --     if not lspconfig.alloyed then
    --         configs.alloyed = {
    --             default_config = {
    --                 cmd = { 'lua-lsp' },
    --                 filetypes = { 'lua' },
    --                 root_dir = function(fname)
    --                     return util.root_pattern('.luacheckrc', '.luacompleterc', '.git')
    --                         or util.path.dirname(fname)
    --                         or vim.loop.os_homedir()
    --                 end,
    --                 settings = {}
    --             },
    --         }
    --     end

    lspconfig.cssls.setup({
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.efm.setup({
        cmd = {
            'efm-langserver', '-logfile', os.getenv('HOME') .. '/efm.log',
            '-loglevel', '2'
        },
        root_dir = util.root_pattern("package.json", ".git/"),
        init_options = {
            documentFormatting = true,
            hover = false,
            documentSymbol = true,
            codeAction = true,
            completion = false
        },
        settings = {
            rootMarkers = {"package.json", ".git/"},
            languages = {
                lua = {lua_format},
                vim = {vint},
                typescript = {prettier, tslint, eslint},
                javascript = {prettier, eslint},
                typescriptreact = {prettier, tslint, eslint},
                javascriptreact = {prettier, eslint},
                yaml = {prettier},
                json = {prettier},
                html = {prettier},
                scss = {prettier},
                css = {prettier},
                markdown = {prettier}
            }
        },
        filetypes = {
            "lua", "vim", "javascript", "javascriptreact", "javascript.jsx",
            "typescript", "typescriptreact", "typescript.tsx"
        },
        on_attach = custom_attach,
        capabilities = capabilities,
        log_level = vim.lsp.protocol.MessageType.Log,
        message_level = vim.lsp.protocol.MessageType.Log
    })

    lspconfig.html.setup({
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.jsonls.setup({
        cmd = {'json-languageserver'},
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.rust_analyzer.setup({
        cmd = {"rust-analyzer"},
        filetypes = {"rust"},
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.sumneko_lua.setup({
        cmd = {
            'lua-language-server', "-E",
            os.getenv('HOME') .. '/Tools/lua-language-server/main.lua'
        },
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ';')
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                },
                diagnostics = {
                    enable = true,
                    globals = {
                        "hs", "vim", "it", "describe", "before_each",
                        "after_each"
                    },
                    disable = {"lowercase-global"}
                },
                completion = {keywordSnippet = "Disable"}
            }
        },
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.tsserver.setup({
        cmd = {"typescript-language-server", "--stdio"},
        filetypes = {
            "javascript", "javascriptreact", "javascript.jsx", "typescript",
            "typescriptreact", "typescript.tsx"
        },
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.vimls.setup({
        on_attach = custom_attach,
        capabilities = capabilities
    })

    lspconfig.yamlls.setup({
        on_attach = custom_attach,
        capabilities = capabilities
    })

    --     lspconfig.alloyed.setup({
    --         on_attach = custom_attach,
    --         capabilities = capabilities
    --     })

    vim.fn.sign_define("LspDiagnosticsSignError", {text = "✗", texthl = "LspDiagnosticsSignError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "‼", texthl = "LspDiagnosticsSignWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "𝒊", texthl = "LspDiagnosticsSignInformation"})
    vim.fn.sign_define("LspDiagnosticsSignHint", {text = "▶", texthl = "LspDiagnosticsSignHint"})

    -- Go to definition
    vimp.nnoremap({'silent'}, '<Leader>gd',
                  function() vim.lsp.buf.definition() end)

    -- Peek definition
    vimp.nnoremap({'silent'}, '<Leader>@',
                  function() vim.cmd('PeekDefinition') end)

    -- Go to implementation
    vimp.nnoremap({'silent'}, '<Leader>gi',
                  function() vim.lsp.buf.implementation() end)

    -- Go to type definition
    vimp.nnoremap({'silent'}, '<Leader>gtd',
                  function() vim.lsp.buf.type_definition() end)

    -- Go to references
    vimp.nnoremap({'silent'}, '<Leader>gr',
                  function() vim.lsp.buf.references() end)

    -- Code action
    vimp.nnoremap({'silent'}, '<Leader>ca',
                  function() vim.lsp.buf.code_action() end)

    -- Rename
    vimp.nnoremap({'silent'}, '<Leader>r', function() vim.lsp.buf.rename() end)

    -- Hover
    vimp.nnoremap({'silent'}, 'K', function() vim.lsp.buf.hover() end)

    -- Open diagnostics
    vimp.nnoremap({'silent'}, '<Leader>-',
                  function() vim.lsp.diagnostic.set_loclist() end)

    -- Signature help
    vimp.nnoremap({'silent'}, '<Leader>sh',
                  function() vim.lsp.buf.signature_help() end)

    -- Go to next diagnostic
    vimp.nnoremap({'silent'}, ']d',
                  function() vim.lsp.diagnostic.goto_next() end)

    -- Go to previous diagnostic
    vimp.nnoremap({'silent'}, '[d',
                  function() vim.lsp.diagnostic.goto_prev() end)

    -- Highlight the current symbol in the document
    vim.api.nvim_command [[
        augroup DocumentHighlight
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        augroup END
    ]]

    -- Clear highlight when leaving the current symbol in the document
    vim.api.nvim_command [[
        augroup ClearReferences
        autocmd! * <buffer>
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
    ]]

    -- Highlight the current symbol in the document
    vim.api.nvim_command [[
        augroup Completion
        autocmd! * <buffer>
        autocmd BufEnter * lua require'completion'.on_attach()
        augroup END
    ]]
end

return M
