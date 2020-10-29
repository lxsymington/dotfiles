local nvim_lsp = require'nvim_lsp'
local on_attach_vim = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

nvim_lsp.cssls.setup {on_attach=on_attach_vim}
nvim_lsp.html.setup {on_attach=on_attach_vim}
nvim_lsp.jsonls.setup {on_attach=on_attach_vim}
nvim_lsp.rust_analyzer.setup {on_attach=on_attach_vim}
nvim_lsp.sumneko_lua.setup {
    cmd = { "~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/macOS/lua-language-server", "-E", "~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
    on_attach=on_attach_vim
}
nvim_lsp.tsserver.setup {on_attach=on_attach_vim}
nvim_lsp.vimls.setup {on_attach=on_attach_vim}
nvim_lsp.yamlls.setup {on_attach=on_attach_vim}
