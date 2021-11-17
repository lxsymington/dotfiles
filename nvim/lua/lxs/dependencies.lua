local M = {}

-- Packer ------------------------------
function M.setup()
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
        autocmd!
        autocmd BufWritePost dependencies.lua PackerCompile
        augroup END
    ]],
		false
	)

	require('packer').startup({
		function(use)
			-- Packer can manage itself as an optional plugin
			use({ 'wbthomason/packer.nvim', opt = true })

			-- Utilities
			use('nvim-lua/popup.nvim')
			use('nvim-lua/plenary.nvim')

			-- Keybindings
			use({
				'folke/which-key.nvim',
				config = function()
					require('which-key').setup({ window = { winblend = 10 } })
				end,
			})

			-- LSP configurations
			use({
				'williamboman/nvim-lsp-installer',
				requires = {
					'neovim/nvim-lspconfig',
					'nvim-lua/lsp-status.nvim',
					'nvim-lua/lsp_extensions.nvim',
					'folke/lua-dev.nvim',
				},
				config = function()
					require('lxs.lsp').setup()
				end,
			})

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
							require('org-bullets').setup()
						end,
					},
				},
				config = function()
					require('lxs.plugin_settings.orgmode').setup()
				end,
			})

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
				'nvim-telescope/telescope.nvim',
				requires = {
					'nvim-lua/popup.nvim',
					'nvim-lua/plenary.nvim',
					'neovim/nvim-lspconfig',
					'tami5/sqlite.lua',
					'nvim-telescope/telescope-symbols.nvim',
					'nvim-telescope/telescope-frecency.nvim',
					{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
				},
				config = function()
					require('lxs.plugin_settings.telescope').setup()
				end,
				opt = true,
				cmd = { 'Telescope', 'Octo' },
				keys = {
					{ 'n', '<Leader>pf' },
					{ 'n', '<Leader>ps' },
					{ 'n', '<Leader>lcc' },
					{ 'n', '<Leader>lcr' },
					{ 'n', '<Leader>lr' },
					{ 'n', '<Leader>ldd' },
					{ 'n', '<Leader>ldw' },
					{ 'n', '<Leader>ls' },
					{ 'n', '<Leader>gf' },
					{ 'n', '<Leader>gs' },
					{ 'n', '<Leader>gb' },
					{ 'n', '<Leader>vh' },
					{ 'n', '<Leader>vm' },
					{ 'n', '<Leader>bf' },
					{ 'n', '<Leader>b/' },
					{ 'n', '<Leader><Tab>' },
					{ 'n', '<Leader><Leader>' },
					{ 'n', '<Leader>/' },
					{ 'n', '<Leader>;' },
					{ 'n', '<Leader>hz' },
				},
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
				},
				requires = {
					'neovim/nvim-lspconfig',
					'nvim-lua/lsp-status.nvim',
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
				opt = true,
				keys = {
					{ 'n', '<F5>' },
					{ 'n', '<Leader>b' },
					{ 'n', '<Leader>B' },
					{ 'n', '<Leader>lp' },
				},
				config = function()
					require('lxs.plugin_settings.nvim_dap').setup()
				end,
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
				'rcarriga/vim-ultest',
				requires = { 'vim-test/vim-test' },
				run = ':UpdateRemotePlugins',
				config = function()
					require('lxs.plugin_settings.ultest').setup()
				end,
			})

			-- Markdown Preview
			use({
				'euclio/vim-markdown-composer',
				run = 'cargo build --release',
				opt = true,
				ft = { 'md' },
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
			use({
				'rcarriga/nvim-notify',
				config = function()
					require('lxs.plugin_settings.notify').setup()
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
		end,
		config = {
			display = {
				open_fn = function()
					return require('packer.util').float({ border = 'single' })
				end,
				prompt_border = 'rounded',
			},
		},
	})
end

return M
