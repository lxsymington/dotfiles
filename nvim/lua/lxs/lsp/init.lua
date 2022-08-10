local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local luadev = require('lua-dev')
local Job = require('plenary.job')
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

local function get_node_path()
    local volta_job = Job:new({
        command = 'volta',
        args = {  'run', '--node 16', 'which', 'node' },
        cwd = vim.loop.cwd()
    })

    volta_job:start()
    volta_job:wait(1000, 5)
    volta_job:after(function ()
        volta_job:shutdown()
    end)

    return volta_job:result()
end

local server_opts = {
	['denols'] = function()
		return tbl_extend('keep', {
			init_options = {
			    enable = vim.fn.filereadable('deno.json') == 1
			        or vim.fn.filereadable('deno.jsonc') == 1,
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
				},
				nodePath = get_node_path()
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
	-- Convenience command to view lsp logs
	vim.api.nvim_create_user_command('LspLog', function ()
	   vim.cmd.tabnew(vim.lsp.get_log_path())
	end, {
	    desc = 'LSP » Open Logs In New Tab',
	})

	-- Setup handlers
	handlers.setup()

	-- Setup preview
	preview.setup()

	-- Setup signs
	signs.setup()

	-- Pretty icons
	vim.lsp.protocol.CompletionItemKind = constants.kind_labels

	-- Configure `mason`
	mason.setup({
		log_level = vim.log.levels.DEBUG,
		ui = {
		    border = 'rounded',
			icons = {
				package_installed = '✔',
				package_pending = '➜',
				package_uninstalled = '✘',
			},
		},
	})
	mason_lspconfig.setup({
		automatic_installation = true,
	})

	for server_name, server_config in pairs(server_opts) do
		lspconfig[server_name].setup(server_config())
	end
end

return M
