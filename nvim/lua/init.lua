-- Stolen from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/plugins.lua
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
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim")

  return
end

return require('packer').startup {
  function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Lazy loading:
    -- Load on specific commands
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- LSP configurations
    use 'neovim/nvim-lspconfig'

    -- Highlight colours
    use {'norcalli/nvim-colorizer.lua', setup = function() css = true end, }

    -- Registers
    use 'junegunn/vim-peekaboo'

    -- Search
    use {'nvim-lua/telescope.nvim', opt = true, requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}}

    -- Highlighting
    use {'nvim-treesitter/nvim-treesitter', config = 'require("treesitter")'}

    -- Completion
    use {'nvim-lua/completion-nvim', event = 'InsertEnter *', config = 'require("lsp")'}
    use {'nvim-treesitter/completion-treesitter', opt = true}

    -- Diagnostics
    use 'nvim-lua/diagnostic-nvim'

    -- Status
    use 'nvim-lua/lsp-status.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Languages
    use 'sheerun/vim-polyglot'

    -- Syntax
    use 'HerringtonDarkholme/yats.vim'

    -- Focus
    use 'TaDaa/vimade'

    -- Colors
    use 'amadeus/vim-convert-color-to'

    -- Tmux
    use 'christoomey/vim-tmux-navigator'

    -- Editor config
    use 'editorconfig/editorconfig-vim'

    -- File explorer
    use 'lambdalisue/fern-git-status.vim'
    use 'lambdalisue/fern-renderer-nerdfont.vim'
    use 'lambdalisue/fern.vim'
    use 'lambdalisue/glyph-palette.vim'
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
    use 'mhinz/vim-startify'

    -- Debugger
    use 'puremourning/vimspector'

    -- Pairing
    use 'tmsvg/pear-tree'

    -- Commenting
    use 'tpope/vim-commentary'

    -- Version Control
    use 'tpope/vim-fugitive'

    -- Test runner
    use 'vim-test/vim-test'
  end,
  _config = {
    display = {
      _open_fn = function(name)
        -- We can only use plenary once the plugins are loaded
        -- We can only get plenary before the plugins are loaded
        local ok, float_win = pcall(function()
          return require('plenary.window.float').percentage_range_window(0.8, 0.8)
        end)

        if not ok then
          vim.cmd [[65vnew [packer] ]]

          return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
        end

        local bufnr = float_win.buf
        local win = float_win.win

        vim.api.nvim_buf_set_name(bufnr, name)
        vim.api.nvim_win_set_option(win, 'winblend', 10)

        return win, bufnr
      end
    },
  }
}
