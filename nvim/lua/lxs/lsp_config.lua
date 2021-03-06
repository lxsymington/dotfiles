local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local lsp_status = require("lsp-status")
local luadev = require("lua-dev")
local vint = require("lxs.plugin_settings.efm.vint")
local stylua = require("lxs.plugin_settings.efm.stylua")
local prettier = require("lxs.plugin_settings.efm.prettier")
local eslint = require("lxs.plugin_settings.efm.eslint")
local tslint = require("lxs.plugin_settings.efm.tslint")
local keymap = vim.api.nvim_set_keymap
local M = {}

-- Pretty icons
vim.lsp.protocol.CompletionItemKind = {
	" [text]",
	" [method]",
	" [function]",
	" [constructor]",
	"ﰠ [field]",
	" [variable]",
	" [class]",
	" [interface]",
	" [module]",
	" [property]",
	" [unit]",
	" [value]",
	" [enum]",
	" [key]",
	"﬌ [snippet]",
	" [color]",
	" [file]",
	" [reference]",
	" [folder]",
	" [enum member]",
	" [constant]",
	" [struct]",
	"⌘ [event]",
	" [operator]",
	"♛ [type]",
}

-- Formatting
local format_options_prettier = {
	tabWidth = 4,
	singleQuote = true,
	trailingComma = "all",
	configPrecedence = "prefer-file",
}

vim.g.format_options_typescript = format_options_prettier
vim.g.format_options_javascript = format_options_prettier
vim.g.format_options_typescriptreact = format_options_prettier
vim.g.format_options_javascriptreact = format_options_prettier
vim.g.format_options_css = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_markdown = format_options_prettier

function FormatToggle(value)
	vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end

vim.cmd([[command! FormatDisable lua FormatToggle(true)]])
vim.cmd([[command! FormatEnable lua FormatToggle(false)]])

_G.formatting = function()
	if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
		print("Formatting file...")
		vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
	end
end

-- Preview definition
local function preview_location_callback(_, _, result)
	if result == nil or vim.tbl_isempty(result) then
		return nil
	end
	vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end

vim.cmd([[command! PeekDefinition lua PeekDefinition()]])

-- Turn on status.
lsp_status.register_progress()

-- Enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}
capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

-- Attach
local custom_attach = function(client)
	lsp_status.on_attach(client)

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_exec(
			[[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> lua formatting()
            augroup END
        ]],
			true
		)
	end

	if client.resolved_capabilities.document_highlight then
		-- Highlight the current symbol in the document
		-- Clear highlight when leaving the current symbol in the document
		vim.api.nvim_exec(
			[[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
			false
		)
	end

	-- stylua: ignore
	-- Rust is currently the only thing w/ inlay hints
	if vim.api.nvim_buf_get_option(0, "filetype") == "rust" then
		vim.api.nvim_exec(
			[[
            augroup InlayHints
            autocmd! * <buffer>
            autocmd BufEnter,BufWinEnter,TabEnter *.rs lua require('lsp_extensions').inlay_hints({})
            autocmd CursorHold,CursorHoldI *.rs lua require('lsp_extensions').inlay_hints({ aligned = true, prefix = " » " })
            augroup END
        ]],
			false
		)
	end

	vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
end

function M.setup()
	-- Set LSP client's log level. Server's log level is not affected.
	vim.lsp.set_log_level("info")

	vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
		if err ~= nil or result == nil then
			return
		end
		if not vim.api.nvim_buf_get_option(bufnr, "modified") then
			local view = vim.fn.winsaveview()
			vim.lsp.util.apply_text_edits(result, bufnr)
			vim.fn.winrestview(view)
			if bufnr == vim.api.nvim_get_current_buf() then
				vim.api.nvim_command("noautocmd :update")
			end
		end
	end

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		-- Enable underline, use default values
		underline = true,
		-- Enable virtual text, override spacing to 4
		virtual_text = { spacing = 4, prefix = "🔎" },
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		require("lsp_extensions.workspace.diagnostic").handler,
		{
			signs = {
				severity_limit = "Error",
			},
		}
	)

	local servers = { "cssls", "html", "jsonls", "rust_analyzer", "tsserver", "vimls", "yamlls" }

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = custom_attach,
			capabilities = capabilities,
		})
	end

	lspconfig.gopls.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
		cmd = { "gopls", "serve" },
		root_dir = function(fname)
			return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
		end,
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
			},
		},
	})

	--[[ lspconfig.denols.setup({
		init_options = {
			enable = true,
			lint = true,
		},
		on_attach = custom_attach,
		capabilities = capabilities,
	}) ]]

	lspconfig.efm.setup({
		cmd = {
			"efm-langserver",
			"-logfile",
			os.getenv("HOME") .. "/efm.log",
			"-loglevel",
			"2",
		},
		root_dir = util.root_pattern("package.json", ".git/"),
		init_options = {
			documentFormatting = true,
			hover = false,
			documentSymbol = true,
			codeAction = true,
			completion = false,
		},
		settings = {
			rootMarkers = { "package.json", ".git/" },
			languages = {
				lua = { stylua },
				vim = { vint },
				typescript = { prettier, tslint, eslint },
				javascript = { prettier, eslint },
				typescriptreact = { prettier, tslint, eslint },
				javascriptreact = { prettier, eslint },
				yaml = { prettier },
				json = { prettier },
				html = { prettier },
				scss = { prettier },
				css = { prettier },
				markdown = { prettier },
			},
		},
		filetypes = {
			"lua",
			"vim",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"yaml",
			"json",
			"html",
			"scss",
			"css",
			"markdown",
		},
		on_attach = custom_attach,
		capabilities = capabilities,
		log_level = vim.lsp.protocol.MessageType.Log,
		message_level = vim.lsp.protocol.MessageType.Log,
	})

	lspconfig.sumneko_lua.setup(luadev.setup({
		lspconfig = {
			on_attach = custom_attach,
			capabilities = capabilities,

			cmd = {
				"lua-language-server",
				"-E",
				os.getenv("HOME") .. "/Tools/lua-language-server/main.lua",
			},

			root_dir = function(fname)
				return util.find_git_ancestor(fname) or util.path.dirname(fname)
			end,
		},
	}))

	vim.fn.sign_define("LspDiagnosticsSignError", {
		text = "",
		texthl = "LspDiagnosticsSignError",
	})

	vim.fn.sign_define("LspDiagnosticsSignWarning", {
		text = "",
		texthl = "LspDiagnosticsSignWarning",
	})

	vim.fn.sign_define("LspDiagnosticsSignInformation", {
		text = "",
		texthl = "LspDiagnosticsSignInformation",
	})

	vim.fn.sign_define("LspDiagnosticsSignHint", {
		text = "",
		texthl = "LspDiagnosticsSignHint",
	})

	-- Go to definition
	keymap("n", "<Leader>gd", "<Cmd>:lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

	-- Peek definition
	keymap("n", "<Leader>@", "<Cmd>:PeekDefinition<CR>", { noremap = true, silent = true })

	-- Go to implementation
	keymap("n", "<Leader>gi", "<Cmd>:lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })

	-- Go to type definition
	keymap("n", "<Leader>gtd", "<Cmd>:lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })

	-- Go to references
	keymap("n", "<Leader>gr", "<Cmd>:lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })

	-- Code action
	keymap("n", "<Leader>ca", "<Cmd>:lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

	-- Rename
	keymap("n", "<Leader>r", "<Cmd>:lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })

	-- Hover
	keymap("n", "K", "<Cmd>:lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

	-- Open diagnostics
	keymap("n", "<Leader>-", "<Cmd>:lua vim.lsp.diagnostic.set_loclist()<CR>", { noremap = true, silent = true })

	-- Signature help
	keymap("n", "<Leader>sh", "<Cmd>:lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })

	-- Go to next diagnostic
	keymap("n", "]d", "<Cmd>:lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })

	-- Go to previous diagnostic
	keymap("n", "[d", "<Cmd>:lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })

	-- View workspace diagnostics
	keymap(
		"n",
		"<Leader>wd",
		"<Cmd>:lua require('lsp_extensions.workspace.diagnostic').set_qf_list()<CR>",
		{ noremap = true, silent = true }
	)
end

return M
