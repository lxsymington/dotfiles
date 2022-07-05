local lsp_installer = require('nvim-lsp-installer')
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local luadev = require('lua-dev')
local constants = require('lxs.config.constants')
local attach = require('lxs.lsp.attach')
local capabilities = require('lxs.lsp.capabilities')
local handlers = require('lxs.lsp.handlers')
local preview = require('lxs.lsp.preview')
local signs = require('lxs.lsp.signs')
local tbl_extend = vim.tbl_extend
local M = {}

local default_opts = {
	on_attach = attach.attach,
	capabilities = capabilities.create(),
}

local server_opts = {
	['denols'] = function()
		return tbl_extend('keep', {
			init_options = {
				lint = true,
			},
			root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
		}, default_opts)
	end,
	['eslint'] = function()
		return tbl_extend('keep', {
			settings = {
				codeActionOnSave = {
					enable = true,
					mode = 'all',
				},
				format = { enable = true },
			},
		}, default_opts)
	end,
	['gopls'] = function()
		return tbl_extend('keep', {
			cmd = { 'gopls', 'serve' },
			root_dir = function(fname)
				return util.root_pattern('go.mod', '.git')(fname) or util.path.dirname(fname)
			end,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
				},
			},
		}, default_opts)
	end,
	['jsonls'] = function()
		return tbl_extend('keep', {
			settings = {
				json = {
					schemas = require('schemastore').json.schemas(),
					validate = { enable = true },
				},
			},
		}, default_opts)
	end,
	['rust_analyzer'] = function()
		return default_opts
	end,
	['sumneko_lua'] = function()
		return luadev.setup({
		    library = {
		        plugins = { "neotest" },
		        types = true
		    },
			lspconfig = tbl_extend('keep', {
				root_dir = function(fname)
					return util.find_git_ancestor(fname) or util.path.dirname(fname)
				end,
			}, default_opts),
		})
	end,
	['tsserver'] = function()
		return tbl_extend('keep', {
			init_options = {
				lint = true,
			},
			root_dir = util.root_pattern('tsconfig.json', 'package.json'),
		}, default_opts)
	end,
	['vimls'] = function()
		return default_opts
	end,
	['yamlls'] = function()
		return tbl_extend('keep', {
	        yaml = {
	            schemaStore = {
	                enable = true
	            }
	        }
        }, default_opts)
	end,
}

function M.setup()
	-- Set LSP client's log level. Server's log level is not affected.
	vim.lsp.set_log_level('info')

	-- Convenience command to view lsp logs
	vim.cmd([[ command! LspLog exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()") ]])

	-- Setup handlers
	handlers.setup()

	-- Setup preview
	preview.setup()

	-- Setup signs
	signs.setup()

	-- Pretty icons
	vim.lsp.protocol.CompletionItemKind = constants.kind_labels

	-- Configure `nvim-lsp-installer`
	lsp_installer.setup({
		log_level = vim.log.levels.DEBUG,
		automatic_installation = true,
		ui = {
			icons = {
				server_installed = '',
				server_pending = '',
				server_uninstalled = '',
			},
		},
	})

	for server_name, server_config in pairs(server_opts) do
		lspconfig[server_name].setup(server_config())
	end
end

return M
