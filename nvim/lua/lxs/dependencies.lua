local M = {}

-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))

	vim.fn.mkdir(directory, 'p')

	local out = vim.fn.system(
		string.format(
			'git clone %s %s',
			'https://github.com/wbthomason/packer.nvim',
			directory .. 'packer.nvim'
		)
	)

	P(out)
	P('Downloading packer.nvim')

	return
end

vim.api.nvim_exec(
	[[
        augroup Packer
        autocmd! * <buffer>
        autocmd BufWritePost dependencies.lua PackerCompile
        augroup END
    ]],
	false
)

-- Packer ------------------------------
function M.setup()
	require('packer').startup(function(use)
		-- Packer can manage itself as an optional plugin
		use({ 'wbthomason/packer.nvim', opt = true })

		-- Config
		use('tjdevries/astronauta.nvim')

		-- Utilities
		use('nvim-lua/popup.nvim')
		use('nvim-lua/plenary.nvim')

		-- Highlighting
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
				{ 'o', '<silent> m' },
				{ 'v', '<silent> m' },
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
			config = function()
				require('lxs.plugin_settings.treesitter_playground').setup()
			end,
		})

		-- Note taking
		-- TODO: Config for orgmode
		use({
			'kristijanhusak/orgmode.nvim',
			branch = 'tree-sitter',
			config = function()
				require('orgmode').setup({
					org_agenda_files = { '~/Documents/org_agenda' },
					org_default_notes_files = { '~/Documents/org_notes' },
				})
			end,
		})

		-- Icons
		use({ 'kyazdani42/nvim-web-devicons' })

		-- Snippets
		use({
			'L3MON4D3/LuaSnip',
			config = function()
				require('lxs.plugin_settings.snippets').setup()
			end,
		})

		-- Completion
		use({
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-buffer',
				'saadparwaiz1/cmp_luasnip',
			},
			config = function()
				require('lxs.plugin_settings.cmp').setup()
			end,
		})

		-- LSP configurations
		use({
			'neovim/nvim-lspconfig',
			requires = {
				'nvim-lua/lsp-status.nvim',
				'nvim-lua/lsp_extensions.nvim',
				'folke/lua-dev.nvim',
			},
			config = function()
				require('lxs.lsp').setup()
			end,
		})

		-- LSP workspace diagnostics
		use({
			'folke/lsp-trouble.nvim',
			after = 'nvim-web-devicons',
			config = function()
				require('lxs.plugin_settings.lsp_trouble').setup()
			end,
			opt = true,
			cmd = {
				'LspTrouble',
				'LspTroubleClose',
				'LspTroubleDocumentOpen',
				'LspTroubleDocumentToggle',
				'LspTroubleOpen',
				'LspTroubleRefresh',
				'LspTroubleToggle',
				'LspTroubleWorkspaceOpen',
				'LspTroubleWorkspaceToggle',
			},
			keys = { 'n', '<Leader>lt' },
		})

		-- LSP file outline
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
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
		})
		use({
			'nvim-telescope/telescope-frecency.nvim',
			requires = { 'tami5/sqlite.lua' },
		})
		use({
			'nvim-telescope/telescope.nvim',
			after = {
				'telescope-fzf-native.nvim',
				'telescope-frecency.nvim',
			},
			requires = {
				'nvim-lua/popup.nvim',
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope-symbols.nvim',
			},
			config = function()
				require('lxs.plugin_settings.telescope').setup()
			end,
			opt = true,
			cmd = { 'Telescope', 'Octo' },
			keys = {
				{ 'n', '<Leader>p' },
				{ 'n', '<Leader>pf' },
				{ 'n', '<Leader>ps' },
				{ 'n', '<Leader>p/' },
				{ 'n', '<Leader>la' },
				{ 'n', '<Leader>lar' },
				{ 'n', '<Leader>lr' },
				{ 'n', '<Leader>ld' },
				{ 'n', '<Leader>ldw' },
				{ 'n', '<Leader>gf' },
				{ 'n', '<Leader>gs' },
				{ 'n', '<Leader>gb' },
				{ 'n', '<Leader>vh' },
				{ 'n', '<Leader>vm' },
				{ 'n', '<Leader>bf' },
				{ 'n', '<Leader>b/' },
				{ 'n', '<Leader>hz' },
				{ 'n', '<Leader>;' },
			},
		})

		-- Version Control
		use({
			'TimUntersberger/neogit',
			config = function()
				require('lxs.plugin_settings.neogit').setup()
			end,
			opt = true,
			cmd = { 'Neogit' },
			keys = { 'n', '<Leader>g' },
		})
		use({
			'tpope/vim-fugitive',
			config = function()
				require('lxs.plugin_settings.fugitive').setup()
			end,
		})
		use({
			'lewis6991/gitsigns.nvim',
			after = { 'plenary.nvim' },
			config = function()
				require('lxs.plugin_settings.gitsigns').setup()
			end,
		})

		-- Statusline
		use({
			'famiu/feline.nvim',
			after = {
				'nvim-web-devicons',
				'gitsigns.nvim',
				'nvim-lspconfig',
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
			requires = { 'theHamsta/nvim-dap-virtual-text' },
			config = function()
				require('lxs.plugin_settings.nvim_dap').setup()
			end,
		})
		use({
			'nvim-telescope/telescope-dap.nvim',
			after = { 'telescope.nvim', 'nvim-dap' },
			config = function()
				require('lxs.plugin_settings.nvim_dap.telescope_integration').setup()
			end,
		})
		use({
			'rcarriga/nvim-dap-ui',
			after = { 'nvim-dap' },
		})

		-- Markdown Preview
		use({
			'euclio/vim-markdown-composer',
			run = 'cargo build --release',
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
			after = { 'telescope.nvim' },
			opt = true,
			cmd = { 'Octo' },
			config = function()
				require('octo').setup()
			end,
		})

		-- UI tweaks
		use({
			'folke/todo-comments.nvim',
			requires = 'nvim-lua/plenary.nvim',
			config = function()
				require('todo-comments').setup()
			end,
		})
		use({
			'folke/zen-mode.nvim',
			config = function()
				require('lxs.plugin_settings.zen_mode').setup()
			end,
		})
		use({
			'folke/twilight.nvim',
			config = function()
				require('twilight').setup()
			end,
		})
		use({
			'folke/which-key.nvim',
			config = function()
				require('which-key').setup()
			end,
		})

		-- Colors
		use({
			'amadeus/vim-convert-color-to',
			opt = true,
			cmd = { 'ConvertColorTo' },
		})

		-- Colorscheme builder
		use('rktjmp/lush.nvim')

		-- Usability
		use('tpope/vim-abolish')

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
	end, {
		display = {
			open_fn = require('packer.util').float,
		},
	})
end

return M
