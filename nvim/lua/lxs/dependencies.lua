-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

	vim.fn.mkdir(directory, "p")

	local out = vim.fn.system(string.format(
		"git clone %s %s",
		"https://github.com/wbthomason/packer.nvim",
		directory .. "packer.nvim"
	))

	print(out)
	print("Downloading packer.nvim")

	return
end

vim.api.nvim_exec(
	[[
        augroup Packer
            autocmd!
            autocmd BufWritePost dependencies.lua PackerCompile
        augroup end
    ]],
	false
)

return require("packer").startup(function(use)
	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim", opt = true })

	-- Config
	use("tjdevries/astronauta.nvim")

	-- Utilities
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	-- Highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require("lxs.plugin_settings.treesitter")
		end,
		run = function()
			vim.cmd("TSUpdate")
		end,
	})

	use({ "kyazdani42/nvim-web-devicons" })

	-- File Explorer
	use({
		"kyazdani42/nvim-tree.lua",
		after = "nvim-web-devicons",
		config = function()
			require("lxs.plugin_settings.nvim_tree").setup()
		end,
		opt = true,
		cmd = {
			"NvimTreeClipboard",
			"NvimTreeClose",
			"NvimTreeFindFile",
			"NvimTreeOpen",
			"NvimTreeRefresh",
			"NvimTreeToggle",
		},
		keys = { "n", "<Leader><Tab>" },
	})

	-- Snippets
	use({
		"norcalli/snippets.nvim",
		config = function()
			require("lxs.plugin_settings.snippets").setup()
		end,
	})

	-- Neovim Lua Helper
	use("tjdevries/nlua.nvim")
	use("euclidianAce/BetterLua.vim")
	use("bfredl/nvim-luadev")

	-- Completion
	use({
		"hrsh7th/nvim-compe",
		config = function()
			require("lxs.plugin_settings.compe").setup()
		end,
	})

	-- LSP configurations
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"nvim-lua/lsp-status.nvim",
			"nvim-lua/lsp_extensions.nvim",
			"folke/lua-dev.nvim"
		},
		config = function()
			require("lxs.lsp_config").setup()
		end,
	})

	-- LSP workspace diagnostics
	use({
		"folke/lsp-trouble.nvim",
		after = "nvim-web-devicons",
		config = function()
			require("lxs.plugin_settings.lsp_trouble").setup()
		end,
		opt = true,
		cmd = {
			"LspTrouble",
			"LspTroubleClose",
			"LspTroubleDocumentOpen",
			"LspTroubleDocumentToggle",
			"LspTroubleOpen",
			"LspTroubleRefresh",
			"LspTroubleToggle",
			"LspTroubleWorkspaceOpen",
			"LspTroubleWorkspaceToggle",
		},
		keys = { "n", "<Leader>lt" },
	})

	-- LSP file outline
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("lxs.plugin_settings.symbols_outline").setup()
		end,
		opt = true,
		cmd = {
			"SymbolsOutline",
			"SymbolsOutlineOpen",
			"SymbolsOutlineClose",
		},
		keys = { "n", "<Leader>so" },
	})

	-- Highlight colours
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*", -- Highlight all files, but customize some others.
				css = { css = true }, -- Enable parsing rgb(...) functions in css.
				html = { names = false }, -- Disable parsing "names" like Blue or Gray
			})
		end,
	})

	-- Indent markers
	use({
		"lukas-reineke/indent-blankline.nvim",
		branch = "lua",
		config = function()
			require("lxs.plugin_settings.indent_blankline").setup()
		end,
	})

	-- Search
	use("tami5/sql.nvim")
    use("nvim-telescope/telescope-frecency.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		after = {
			"popup.nvim",
			"plenary.nvim",
			"sql.nvim",
            "telescope-frecency.nvim",
            "telescope-fzy-native.nvim",
		},
		config = function()
			require("lxs.plugin_settings.telescope").setup()
		end,
		opt = true,
		cmd = { "Telescope", "Octo" },
		keys = {
			{ "n", "<Leader>ff" },
			{ "n", "<Leader>fgf" },
			{ "n", "<Leader>fb" },
			{ "n", "<Leader>fd" },
			{ "n", "<Leader>fht" },
			{ "n", "<Leader>lg" },
			{ "n", "<Leader>lbg" },
			{ "n", "<Leader>sr" },
			{ "n", "<Leader><space>" },
			{ "n", "<Leader>?" },
			{ "n", "<Leader>gb" },
			{ "n", "<Leader>gs" },
		},
	})

	-- Version Control
	use({
		"TimUntersberger/neogit",
		config = function()
			require("lxs.plugin_settings.neogit").setup()
		end,
		opt = true,
		cmd = { 'Neogit' },
		keys = { 'n', '<Leader>g' }
	})
	use({
		"tpope/vim-fugitive",
		config = function()
			require("lxs.plugin_settings.fugitive").setup()
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		after = { "plenary.nvim" },
		config = function()
			require("lxs.plugin_settings.gitsigns").setup()
		end,
	})

	-- Statusline
	use({
		"famiu/feline.nvim",
		after = {
			"nvim-web-devicons",
			"gitsigns.nvim",
			"nvim-lspconfig",
		},
		config = function()
			require("lxs.plugin_settings.feline").setup()
		end,
	})

	-- Landing page + sessions
	use({
		"mhinz/vim-startify",
		config = function()
			require("lxs.plugin_settings.startify").setup()
		end,
	})

	-- Debugger
	use({
		"mfussenegger/nvim-dap",
		requires = { "theHamsta/nvim-dap-virtual-text" },
		config = function()
			require("lxs.plugin_settings.nvim_dap").setup()
		end,
	})
	use({
		"nvim-telescope/telescope-dap.nvim",
		after = { "telescope.nvim", "nvim-dap" },
		config = function()
			require("lxs.plugin_settings.nvim_dap.telescope_integration").setup()
		end,
	})
    use({
        "rcarriga/nvim-dap-ui",
        after = {"nvim-dap"}
    })

	-- Markdown Preview
	use({
		"euclio/vim-markdown-composer",
		run = "cargo build --release",
	})

	-- Databases
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = { "tpope/vim-dadbod" },
		opt = true,
		cmd = {
			"DB",
			"DBUI",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUILastQueryInfo",
			"DBUIRenameBuffer",
			"DBUIToggle",
		},
	})

	-- Github
	use({
		"pwntester/octo.nvim",
		after = { "telescope.nvim" },
		opt = true,
		cmd = { "Octo" },
	})

    -- Lua
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end
    }

    -- Lua
    use {
        "folke/zen-mode.nvim",
        config = function()
			require("lxs.plugin_settings.zen_mode").setup()
		end
    }

    -- Lua
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end
    }

	-- Colors
	use({
		"amadeus/vim-convert-color-to",
		opt = true,
		cmd = { "ConvertColorTo" },
	})

	-- Colorscheme builder
	use("rktjmp/lush.nvim")

	-- Colorschemes
	use({ "junegunn/seoul256.vim", opt = true })

	-- Usability
	use("tpope/vim-abolish")

	-- Tmux
	use("christoomey/vim-tmux-navigator")

	-- Editor config
	use("editorconfig/editorconfig-vim")

	-- Surround
	use("machakann/vim-sandwich")

	-- Pairing
	use("tmsvg/pear-tree")

	-- Commenting
	use("b3nj5m1n/kommentary")

	-- Git Author
	use("f-person/git-blame.nvim")
end, {
	display = {
		open_fn = require("packer.util").float,
	},
})
