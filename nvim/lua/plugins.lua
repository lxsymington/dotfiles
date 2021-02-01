-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    local directory = string.format('%s/site/pack/packer/opt/',
                                    vim.fn.stdpath('data'))

    vim.fn.mkdir(directory, 'p')

    local out = vim.fn.system(string.format('git clone %s %s',
                                            'https://github.com/wbthomason/packer.nvim',
                                            directory .. 'packer.nvim'))

    print(out)
    print('Downloading packer.nvim')

    return
end

return require('packer').startup {
    function(use)
        -- Packer can manage itself as an optional plugin
        use {'wbthomason/packer.nvim', opt = true}

        -- Config
        use 'svermeulen/vimpeccable'

        -- Utilities
        use 'nvim-lua/popup.nvim'
        use 'nvim-lua/plenary.nvim'

        -- Highlighting
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {'nvim-treesitter/nvim-treesitter-textobjects'},
            config = function() require('plugin_settings.treesitter') end,
            run = function() vim.cmd('TSUpdate') end
        }

        -- File Explorer
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {'kyazdani42/nvim-web-devicons'},
            config = function()
                require('plugin_settings.nvim_tree').setup()
            end
        }

        -- LSP configurations
        use {
            'neovim/nvim-lspconfig',
            requires = {
                'nvim-lua/completion-nvim', 'nvim-lua/lsp-status.nvim',
                'nvim-treesitter/completion-treesitter'
            },
            config = function() require('lsp_config').setup() end
        }

        -- Highlight colours
        use {
            'norcalli/nvim-colorizer.lua',
            config = function()
                require'colorizer'.setup(
                    {
                        '*', -- Highlight all files, but customize some others.
                        css = {css = true}, -- Enable parsing rgb(...) functions in css.
                        html = {names = false} -- Disable parsing "names" like Blue or Gray
                    })
            end
        }

        -- Search
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'popup.nvim', 'plenary.nvim'},
            config = function()
                require('plugin_settings.telescope').setup()
            end
        }

        -- Syntax
        use {
            'HerringtonDarkholme/yats.vim',
            opt = true,
            ft = {'typescript', 'typescriptreact'}
        }

        -- Version Control
        use {
            'tpope/vim-fugitive',
            config = function()
                require('plugin_settings.fugitive').setup()
            end
        }
        use {
            'lewis6991/gitsigns.nvim',
            requires = {'plenary.nvim'},
            config = function() require('gitsigns').setup() end
        }

        -- Colors
        use {
            'amadeus/vim-convert-color-to',
            opt = true,
            cmd = {'ConvertColorTo'}
        }

        -- Tmux
        use 'christoomey/vim-tmux-navigator'

        -- Editor config
        use 'editorconfig/editorconfig-vim'

        -- Statusline
        use {
            'tjdevries/express_line.nvim',
            requires = {'plenary.nvim'},
            config = function()
                require('plugin_settings.expressline').setup()
            end
        }

        -- Colorscheme builder
        use 'rktjmp/lush.nvim'

        -- Colorschemes
        use {'junegunn/seoul256.vim', opt = true}

        -- Surround
        use 'machakann/vim-sandwich'

        -- Landing page + sessions
        use {
            'mhinz/vim-startify',
            config = function()
                require('plugin_settings.startify').setup()
            end
        }

        -- Code Action Discoverability
        use {
            'kosayoda/nvim-lightbulb',
            config = function()
                require('plugin_settings.nvim_lightbulb').setup()
            end
        }

        -- Debugger
        use {
            'mfussenegger/nvim-dap',
            opt = true,
            cmd = {
                'DebugCommands', 'DebugConfigurations', 'DebugListBreakpoints',
                'DebugLoadLaunchJS', 'DebugVariables'
            },
            keys = {'<F5>'},
            requires = {'theHamsta/nvim-dap-virtual-text'},
            config = function()
                require('plugin_settings.nvim_dap').setup()
            end
        }
        use {
            'nvim-telescope/telescope-dap.nvim',
            after = {'telescope.nvim', 'nvim-dap'},
            config = function()
                require('plugin_settings.nvim_dap.telescope_integration').setup()
            end
        }

        -- Github
        use {
            'pwntester/octo.nvim',
            after = {'telescope.nvim'},
            opt = true,
            cmd = {'Octo'}
        }

        -- Highlighting
        use 'sheerun/vim-polyglot'

        -- Pairing
        use 'tmsvg/pear-tree'

        -- Commenting
        use 'tpope/vim-commentary'
    end
}
