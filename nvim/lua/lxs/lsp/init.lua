local lsp_installer = require('nvim-lsp-installer')
local util = require('lspconfig.util')
local lsp_status = require('lsp-status')
local luadev = require('lua-dev')
local attach = require('lxs.lsp.attach')
local capabilities = require('lxs.lsp.capabilities')
local formatting = require('lxs.lsp.formatting')
local handlers = require('lxs.lsp.handlers')
local preview = require('lxs.lsp.preview')
local signs = require('lxs.lsp.signs')
local prettier = require('lxs.plugin_settings.efm.prettier')
local stylua = require('lxs.plugin_settings.efm.stylua')
local tslint = require('lxs.plugin_settings.efm.tslint')
local vint = require('lxs.plugin_settings.efm.vint')
local tbl_extend = vim.tbl_extend
local M = {}

local function server_setup(server)
	local default_opts = {
		on_attach = attach.attach,
		capabilities = capabilities.create(),
	}

	local server_opts = {
		--[[ ["denols"] = function()
            return tbl_extend("keep", {
                init_options = {
                    enable = true,
                    lint = true,
                },
            }, default_opts)
        end, ]]
		['efm'] = function()
			return tbl_extend('keep', {
				cmd = {
					'efm-langserver',
					'-loglevel',
					'2',
					'-logfile',
					os.getenv('HOME') .. '/efm.log',
				},
				filetypes = {
					'lua',
					'vim',
					'javascript',
					'javascriptreact',
					'javascript.jsx',
					'typescript',
					'typescriptreact',
					'typescript.tsx',
					'yaml',
					'json',
					'html',
					'scss',
					'css',
					'markdown',
				},
				flags = { debounce_text_changes = 1200 },
				init_options = {
					codeAction = false,
					completion = false,
					documentFormatting = true,
					documentSymbol = false,
					document_formatting = true,
					hover = false,
				},
				log_level = vim.lsp.protocol.MessageType.Log,
				message_level = vim.lsp.protocol.MessageType.Log,
				root_dir = util.root_pattern('package.json', '.git/'),
				settings = {
					rootMarkers = { 'package.json', '.git/' },
					lintDebounce = '300ms',
					formatDebounce = '1200ms',
					languages = {
						lua = { stylua },
						vim = { vint },
						typescript = { prettier, tslint },
						javascript = { prettier },
						typescriptreact = { prettier, tslint },
						javascriptreact = { prettier },
						yaml = { prettier },
						json = { prettier },
						html = { prettier },
						scss = { prettier },
						css = { prettier },
						markdown = { prettier },
					},
				},
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

	-- Setup formatting
	formatting.setup()

	-- Setup handlers
	handlers.setup()

	-- Setup preview
	preview.setup()

	-- Setup signs
	signs.setup()

	-- Pretty icons
	vim.lsp.protocol.CompletionItemKind = {
		' [text]',
		' [method]',
		' [function]',
		' [constructor]',
		'ﰠ [field]',
		' [variable]',
		' [class]',
		' [interface]',
		' [module]',
		' [property]',
		' [unit]',
		' [value]',
		' [enum]',
		' [key]',
		'﬌ [snippet]',
		' [color]',
		' [file]',
		' [reference]',
		' [folder]',
		' [enum member]',
		' [constant]',
		' [struct]',
		'⌘ [event]',
		' [operator]',
		' [type]',
	}

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

	-- local servers = { "cssls", "html", "jsonls", "rust_analyzer", "tsserver", "vimls", "yamlls" }
end

return M
