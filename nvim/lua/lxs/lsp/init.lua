local lsp_installer = require('nvim-lsp-installer')
local util = require('lspconfig.util')
local lsp_status = require('lsp-status')
local luadev = require('lua-dev')
local constants = require('lxs.config.constants')
local attach = require('lxs.lsp.attach')
local capabilities = require('lxs.lsp.capabilities')
local formatting = require('lxs.lsp.formatting')
local handlers = require('lxs.lsp.handlers')
local preview = require('lxs.lsp.preview')
local signs = require('lxs.lsp.signs')
local null_ls = require('null-ls')
local tbl_extend = vim.tbl_extend
local M = {}

local function server_setup(server)
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
					cmd = vim.list_extend({ 'yarn', 'node' }, default_opts.cmd),
					codeActionOnSave = {
						enable = true,
						mode = 'all',
					},
					format = { enable = true },
				},
			}, default_opts)
		end,
		['jsonls'] = function()
			return tbl_extend('keep', {
				settings = {
					json = {
						schemas = {
							{
								fileMatch = { 'package.json' },
								url = 'https://json.schemastore.org/package.json',
							},
							{
								fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
								url = 'https://json.schemastore.org/tsconfig',
							},
							{
								fileMatch = { 'lerna.json' },
								url = 'https://json.schemastore.org/lerna',
							},
							{
								fileMatch = { '.eslintrc.json', '.eslintrc' },
								url = 'https://json.schemastore.org/eslintrc',
							},
							{
								fileMatch = {
									'.prettierrc',
									'.prettierrc.json',
									'prettier.config.json',
								},
								url = 'https://json.schemastore.org/prettierrc',
							},
							{
								fileMatch = { 'deno.json', 'deno.jsonc' },
								url = 'https://cdn.deno.land/deno/versions/v1.16.4/raw/cli/schemas/config-file.v1.json',
							},
						},
					},
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
		['sumneko_lua'] = function()
			return luadev.setup({
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
	}

	server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)

	vim.cmd([[ do User LspAttachBuffers ]])
end

function M.setup()
	-- Set LSP client's log level. Server's log level is not affected.
	vim.lsp.set_log_level('info')

	-- Convenience command to view lsp logs
	vim.cmd([[ command! LspLog exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()") ]])

	-- Turn on status.
	lsp_status.register_progress()

	-- Configure Lsp status
	lsp_status.config({
		kind_labels = constants.kind_symbols,
		indicator_errors = '',
		indicator_warnings = '',
		indicator_info = '',
		indicator_hint = '',
		indicator_ok = '✔️',
		component_separator = '‖',
		indicator_separator = '⃒ ',
	})

	-- Setup formatting
	formatting.setup()

	-- Setup handlers
	handlers.setup()

	-- Setup preview
	preview.setup()

	-- Setup signs
	signs.setup()

	-- Pretty icons
	vim.lsp.protocol.CompletionItemKind = constants.kind_labels

	-- Configure `nvim-lsp-installer`
	lsp_installer.settings({
		log_level = vim.log.levels.DEBUG,
		ui = {
			icons = {
				server_installed = '',
				server_pending = '',
				server_uninstalled = '',
			},
		},
	})

	lsp_installer.on_server_ready(server_setup)

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.stylelint,
			null_ls.builtins.diagnostics.vint,
			null_ls.builtins.diagnostics.stylelint,
		},
	})
end

return M
