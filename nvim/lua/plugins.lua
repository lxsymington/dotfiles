-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd [[packadd packer.nvim]])

-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
vim._update_package_paths()

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Lazy loading:
    -- Load on specific commands
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- LSP configurations
    use 'neovim/nvim-lspconfig'

    -- Highlight colours
    use 'norcalli/nvim-colorizer.lua'

    -- Registers
    use 'junegunn/vim-peekaboo'

    -- Search
    use {'nvim-lua/telescope.nvim', opt = true }

    -- Highlighting
    use 'nvim-treesitter/nvim-treesitter'

    -- Completion
    use 'nvim-lua/completion-nvim'
    use 'nvim-treesitter/completion-treesitter'

    -- Diagnostics
    use 'nvim-lua/diagnostic-nvim'

    -- Status
    use 'nvim-lua/lsp-status.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Languages
    use 'sheerun/vim-polyglot'
end)
