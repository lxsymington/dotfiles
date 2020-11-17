local ts_configs = require('nvim-treesitter.configs')

return ts_configs.setup {
    ensure_installed = {
        'css',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'regex',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'yaml',
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
    refactor = {
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
        highlight_definitions = { enable = true }
    },
    indent = {
        enable = true
    },
}
