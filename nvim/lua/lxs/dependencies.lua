local stdpath = vim.fn.stdpath
local mkdir = vim.fn.mkdir
local system = vim.fn.system
local isdirectory = vim.fn.isdirectory
local expand = vim.fn.expand

local M = {}

-- Packer ------------------------------
function M.setup()
    -- Only required if you have packer in your `opt` pack
    local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

    if not packer_exists then
        local directory = string.format('%s/site/pack/packer/opt/', stdpath('data'))

        mkdir(directory, 'p')

        local out = system(
            string.format(
                'git clone %s %s',
                'https://github.com/wbthomason/packer.nvim',
                directory .. 'packer.nvim'
            )
        )

        vim.pretty_print(out)
        vim.pretty_print('Downloading packer.nvim')

        return
    end

    require('packer').startup({
        function(use)
            local function local_use(author, package, opts)
                if not isdirectory(expand('~/.dotfiles/plugins/', ':p:~', {})) then
                    print('Could not find a local plugins directory')
                    return
                end

                local plugin_name = author .. '/' .. package
                local plugin_dir = expand('~/.dotfiles/plugins/' .. plugin_name, ':p:~', {})

                if not isdirectory(plugin_dir) then
                    print('Could not find plugin (' .. plugin_name .. ') in local plugins directory')
                end

                opts = opts or {}
                table.insert(opts, 1, plugin_dir)

                use(opts)
            end

            -- Packer can manage itself as an optional plugin
            use({ 'wbthomason/packer.nvim', opt = true })

            -- Performance
            use({
                'lewis6991/impatient.nvim',
                config = function()
                    require('impatient')
                end,
            })
            use('nathom/filetype.nvim')
            use('dstein64/vim-startuptime')

            -- Utilities
            use('nvim-lua/popup.nvim')
            use('nvim-lua/plenary.nvim')

            -- Keybindings
            use({
                'folke/which-key.nvim',
                config = function()
                    require('which-key').setup({
                        plugins = {
                            spelling = {
                                enabled = true,
                                suggestions = 20,
                            },
                        },
                        window = { winblend = 10 },
                    })
                end,
            })

            -- Colorscheme builder
            use({
                'rktjmp/shipwright.nvim',
                requires = {
                    'rktjmp/lush.nvim',
                },
                config = function()
                    require('lxs.plugin_settings.shipwright').setup()
                end,
            })

            -- Vim UI Extensions
            use({
                'rcarriga/nvim-notify',
                config = function()
                    require('lxs.plugin_settings.notify').setup()
                end,
            })

            -- LSP configurations
            use({
                'williamboman/mason.nvim',
                requires = {
                    'williamboman/mason-lspconfig.nvim',
                    'nvim-lua/plenary.nvim',
                    'rcarriga/nvim-notify',
                    'neovim/nvim-lspconfig',
                    'nvim-lua/lsp_extensions.nvim',
                    'folke/lua-dev.nvim',
                    'b0o/SchemaStore.nvim',
                    'hrsh7th/cmp-nvim-lsp',
                    'lukas-reineke/lsp-format.nvim',
                },
                config = function()
                    require('lxs.lsp').setup()
                end,
            })

            -- Treesitter
            use({
                'nvim-treesitter/nvim-treesitter',
                requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
                config = function()
                    require('lxs.plugin_settings.treesitter').setup()
                end,
                run = function()
                    vim.cmd('TSUpdate')
                end,
            })
            use({
                'mfussenegger/nvim-ts-hint-textobject',
                opt = true,
                keys = {
                    { 'o', 'm' },
                    { 'v', 'm' },
                },
                config = function()
                    require('lxs.plugin_settings.tsht').setup()
                end,
            })
            use({
                'nvim-treesitter/playground',
                opt = true,
                cmd = {
                    'TSPlaygroundToggle',
                    'TSHighlightCapturesUnderCursor',
                },
                keys = {
                    { 'n', '<leader>H' },
                },
                config = function()
                    require('lxs.plugin_settings.treesitter_playground').setup()
                end,
            })

            -- Code cleanliness
            use({
                'mfussenegger/nvim-lint',
                config = function()
                    require('lxs.diagnostics.lint').setup()
                end,
            })
            use({
                'mhartington/formatter.nvim',
                config = function()
                    require('lxs.diagnostics.formatter').setup()
                end,
            })
            use({
                'ThePrimeagen/refactoring.nvim',
                requires = {
                    'nvim-lua/plenary.nvim',
                    'nvim-treesitter/nvim-treesitter',
                },
                config = function()
                    require('lxs.diagnostics.refactoring').setup()
                end,
            })

            -- Note taking
            use({
                'kristijanhusak/orgmode.nvim',
                requires = {
                    {
                        'lukas-reineke/headlines.nvim',
                        opt = true,
                        ft = { 'md', 'org' },
                        config = function()
                            require('headlines').setup()
                        end,
                    },
                    {
                        'akinsho/org-bullets.nvim',
                        opt = true,
                        ft = { 'org' },
                        config = function()
                            require('org-bullets').setup({})
                        end,
                    },
                    'michaelb/sniprun',
                },
                config = function()
                    require('lxs.plugin_settings.orgmode').setup()
                end,
            })

            -- Help extensions
            use('milisims/nvim-luaref')
            use('nanotee/luv-vimdocs')

            -- Icons
            use({ 'kyazdani42/nvim-web-devicons' })

            -- Completion
            use({
                'hrsh7th/nvim-cmp',
                requires = {
                    'hrsh7th/cmp-nvim-lsp',
                    'hrsh7th/cmp-nvim-lua',
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-buffer',
                    'L3MON4D3/LuaSnip',
                    'saadparwaiz1/cmp_luasnip',
                    'onsails/lspkind-nvim',
                },
                config = function()
                    require('lxs.plugin_settings.cmp').setup()
                end,
            })

            -- LSP workspace diagnostics
            use({
                'folke/lsp-trouble.nvim',
                requires = { 'kyazdani42/nvim-web-devicons' },
                config = function()
                    require('lxs.plugin_settings.lsp_trouble').setup()
                end,
                opt = true,
                cmd = {
                    'Trouble',
                    'TroubleClose',
                    'TroubleRefresh',
                    'TroubleToggle',
                },
                keys = { 'n', '<Leader>lt' },
            })

            -- LSP visual enhancements
            use({
                'simrat39/symbols-outline.nvim',
                config = function()
                    require('lxs.plugin_settings.symbols_outline').setup()
                end,
                opt = true,
                cmd = {
                    'SymbolsOutline',
                    'SymbolsOutlineOpen',
                    'SymbolsOutlineClose',
                },
                keys = { 'n', '<Leader>so' },
            })
            use({
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                config = function()
                    require("lxs.plugin_settings.lsp_lines").setup()
                end,
            })

            -- Highlight colours
            use({
                'norcalli/nvim-colorizer.lua',
                config = function()
                    require('colorizer').setup({
                        '*', -- Highlight all files, but customize some others.
                        css = { css = true }, -- Enable parsing rgb(...) functions in css.
                        html = { names = false }, -- Disable parsing "names" like Blue or Gray
                    })
                end,
            })

            -- Indent markers
            use({
                'lukas-reineke/indent-blankline.nvim',
                config = function()
                    require('lxs.plugin_settings.indent_blankline').setup()
                end,
            })

            -- Search
            use({
                'nvim-telescope/telescope.nvim',
                requires = {
                    'nvim-lua/popup.nvim',
                    'nvim-lua/plenary.nvim',
                    'neovim/nvim-lspconfig',
                    'tami5/sqlite.lua',
                    'nvim-telescope/telescope-symbols.nvim',
                    'nvim-telescope/telescope-frecency.nvim',
                    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                    'nvim-telescope/telescope-file-browser.nvim',
                },
                config = function()
                    require('lxs.plugin_settings.telescope').setup()
                end,
            })

            -- Version Control
            use({
                'sindrets/diffview.nvim',
                opt = true,
                cmd = {
                    'DiffviewOpen',
                    'DiffviewFileHistory',
                    'DiffviewClose',
                    'DiffviewToggleFiles',
                    'DiffviewFocusFiles',
                    'DiffviewRefresh',
                },
                config = function()
                    require('diffview').setup()
                end,
            })
            use({
                'TimUntersberger/neogit',
                config = function()
                    require('lxs.plugin_settings.neogit').setup()
                end,
                opt = true,
                cmd = { 'Neogit' },
                keys = { 'n', '<Leader>ng' },
            })
            use({
                'tpope/vim-fugitive',
                config = function()
                    require('lxs.plugin_settings.fugitive').setup()
                end,
            })
            use({
                'lewis6991/gitsigns.nvim',
                requires = { 'nvim-lua/plenary.nvim' },
                config = function()
                    require('lxs.plugin_settings.gitsigns').setup()
                end,
            })

            -- Statusline
            use({
                'feline-nvim/feline.nvim',
                requires = {
                    'neovim/nvim-lspconfig',
                    'kyazdani42/nvim-web-devicons',
                    'lewis6991/gitsigns.nvim',
                },
                config = function()
                    require('lxs.plugin_settings.feline').setup()
                end,
            })

            -- Landing page + sessions
            use({
                'mhinz/vim-startify',
                config = function()
                    require('lxs.plugin_settings.startify').setup()
                end,
            })

            -- Debugger
            use({
                'mfussenegger/nvim-dap',
                requires = {
                    'rcarriga/nvim-notify',
                    'theHamsta/nvim-dap-virtual-text',
                    {
                        'nvim-telescope/telescope-dap.nvim',
                        requires = { 'nvim-telescope/telescope.nvim' },
                        config = function()
                            require('lxs.plugin_settings.nvim_dap.telescope_integration').setup()
                        end,
                    },
                    {
                        'rcarriga/nvim-dap-ui',
                        config = function()
                            require('lxs.plugin_settings.dap_ui').setup()
                        end,
                    },
                },
                config = function()
                    require('lxs.plugin_settings.nvim_dap').setup()
                end,
            })

            -- Task Runner
            use({
                'stevearc/overseer.nvim',
                config = function ()
                    require('lxs.plugin_settings.overseer').setup()
                end
            })

            -- REPL / Runner
            use({
                'michaelb/sniprun',
                run = 'bash ./install.sh',
                opt = true,
                cmd = {
                    'SnipRun',
                    'SnipReset',
                    'SnipReplMemoryClean',
                    'SnipTerminate',
                    'SnipInfo',
                    'SnipClose',
                },
                config = function()
                    require('lxs.plugin_settings.sniprun').setup()
                end,
            })

            -- Testing
            use({
                "nvim-neotest/neotest",
                requires = {
                    "nvim-lua/plenary.nvim",
                    "nvim-treesitter/nvim-treesitter",
                    "antoinemadec/FixCursorHold.nvim",
                    'vim-test/vim-test',
                    'mfussenegger/nvim-dap',
                    'nvim-neotest/neotest-vim-test',
                    'haydenmeade/neotest-jest'
                },
                config = function()
                    require('lxs.plugin_settings.neotest').setup()
                end
            })

            -- Documenting
            use({
                'danymat/neogen',
                requires = { 'nvim-treesitter/nvim-treesitter' },
                config = function()
                    require('lxs.plugin_settings.neogen').setup()
                end,
            })

            -- Markdown Preview
            use({
                'euclio/vim-markdown-composer',
                run = 'cargo build --release',
                opt = true,
                ft = { 'markdown', 'md' },
            })

            -- Databases
            use({
                'kristijanhusak/vim-dadbod-ui',
                requires = { 'tpope/vim-dadbod' },
                opt = true,
                cmd = {
                    'DB',
                    'DBUI',
                    'DBUIAddConnection',
                    'DBUIFindBuffer',
                    'DBUILastQueryInfo',
                    'DBUIRenameBuffer',
                    'DBUIToggle',
                },
            })

            -- Github
            use({
                'pwntester/octo.nvim',
                requires = { 'nvim-telescope/telescope.nvim' },
                opt = true,
                cmd = { 'Octo' },
                config = function()
                    require('octo').setup({
                        ssh_aliases = {
                            Seccl = 'github.com',
                            Personal = 'github.com',
                        }
                    })
                end,
            })

            -- UI tweaks
            use('stevearc/dressing.nvim')
            use({
                'folke/todo-comments.nvim',
                requires = { 'nvim-lua/plenary.nvim' },
                config = function()
                    require('todo-comments').setup()
                end,
            })
            use({
                'folke/zen-mode.nvim',
                opt = true,
                cmd = { 'ZenMode' },
                keys = {
                    { 'n', '<leader>zm' },
                },
                config = function()
                    require('lxs.plugin_settings.zen_mode').setup()
                end,
            })
            use({
                'folke/twilight.nvim',
                opt = true,
                cmd = { 'colors' },
                config = function()
                    require('twilight').setup()
                end,
            })
            use({
                'kosayoda/nvim-lightbulb',
                config = function()
                    require('lxs.plugin_settings.lightbulb').setup()
                end,
            })

            -- Colors
            use({
                'amadeus/vim-convert-color-to',
                opt = true,
                cmd = { 'ConvertColorTo' },
            })

            -- Tmux
            use('christoomey/vim-tmux-navigator')

            -- Editor config
            use('editorconfig/editorconfig-vim')

            -- Surround
            use('machakann/vim-sandwich')

            -- Pairing
            use({
                'windwp/nvim-autopairs',
                config = function()
                    require('lxs.plugin_settings.nvim_autopairs')
                end,
            })

            -- Commenting
            use({
                'numToStr/Comment.nvim',
                config = function()
                    require('Comment').setup()
                end,
            })
        end,
        config = {
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'rounded' })
                end,
                prompt_border = 'rounded',
            },
            git = {
                clone_timeout = 180,
            },
            max_jobs = 16,
        },
    })
end

return M
