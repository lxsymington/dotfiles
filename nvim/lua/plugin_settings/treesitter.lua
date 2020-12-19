local ts_configs = require('nvim-treesitter.configs')

-- TREESITTER --------------------------
return ts_configs.setup {
    ensure_installed = {
        'css', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'regex', 'rust',
        'toml', 'tsx', 'typescript', 'yaml'
    },
    highlight = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    },
    refactor = {
        smart_rename = {enable = true, keymaps = {smart_rename = "grr"}},
        highlight_definitions = {enable = true}
    },
    indent = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["<Leader>df"] = "@function.outer",
                ["<Leader>dF"] = "@class.outer"
            }
        }
    }
}
