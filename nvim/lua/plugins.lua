-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. 'packer.nvim'
  ))

  print(out)
  print('Downloading packer.nvim')

  return
end

return require('packer').startup {
  function(use)
    -- Packer can manage itself as an optional plugin
    use {
        'wbthomason/packer.nvim',
        opt = true,
    }

    -- Config
    use 'svermeulen/vimpeccable'

    -- Highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        config = function()
            require('plugin_settings.treesitter')
        end,
        run = function()
            vim.cmd('TSUpdate')
        end,
    }

    -- File Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('plugin_settings.lua_tree').setup()
        end,
    }

    -- LSP configurations
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'nvim-lua/completion-nvim',
            'nvim-lua/lsp-status.nvim',
            'nvim-treesitter/completion-treesitter',
        },
        config = function()
            require('lsp_config').setup()
        end,
    }

    -- Lazy loading:
    -- Load on specific commands
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {
            'Dispatch',
            'Make',
            'Focus',
            'Start',
        },
    }

    -- Highlight colours
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup({
            '*'; -- Highlight all files, but customize some others.
            css = { css = true; }; -- Enable parsing rgb(...) functions in css.
            html = { names = false; } -- Disable parsing "names" like Blue or Gray
        }) end,
    }

    -- Registers
    use 'junegunn/vim-peekaboo'

    -- Search
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
          require('plugin_settings.telescope').setup()
        end,
    }

    -- Languages
    use 'sheerun/vim-polyglot'

    -- Syntax
    use 'HerringtonDarkholme/yats.vim'

    -- Version Control
    use {
        'tpope/vim-fugitive',
        config = function()
            require('plugin_settings.fugitive').setup()
        end,
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }

    -- Focus
    use {
        'TaDaa/vimade',
        config = function()
            require('plugin_settings.vimade').setup()
        end,
    }

    -- Colors
    use 'amadeus/vim-convert-color-to'

    -- Tmux
    use 'christoomey/vim-tmux-navigator'

    -- Editor config
    use 'editorconfig/editorconfig-vim'

    use {
        'tjdevries/express_line.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('plugin_settings.expressline').setup()
        end
    }

    -- File explorer
    use 'lambdalisue/nerdfont.vim'

    -- Colorscheme builder
    use 'lifepillar/vim-colortemplate'

    -- Colorschemes
    use 'franbach/miramare'
    use 'haishanh/night-owl.vim'
    use 'junegunn/seoul256.vim'

    -- Surround
    use 'machakann/vim-sandwich'

    -- Landing page + sessions
    use {
        'mhinz/vim-startify',
        config = function()
            require('plugin_settings.startify').setup()
        end,
    }

    -- Debugger
    use {
        'mfussenegger/nvim-dap',
        requires = 'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('plugin_settings.nvim-dap').setup()
        end,
    }
    -- use {
    --   'puremourning/vimspector',
    --   config = function()
    --     require('plugin_settings.vimspector').setup()
    --   end
    -- }

    -- Pairing
    use 'tmsvg/pear-tree'

    -- Commenting
    use 'tpope/vim-commentary'

    -- Test runner
    use {
        'vim-test/vim-test',
        config = function ()
            require('plugin_settings.vim-test').setup()
        end,
    }
  end,
}
