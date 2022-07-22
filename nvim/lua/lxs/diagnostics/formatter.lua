local lsp_loaded, util = pcall(require, 'lspconfig.util')
local formatter = require('formatter')
local session_augroups = require('lxs.autocommands').session_augroups
local aucmd = vim.api.nvim_create_autocmd
local M = {}

local function select_config_file(config_files)
	for _, config_file in ipairs(config_files) do
		local fullPath = util.path.join(vim.loop.cwd(), config_file)

		if vim.fn.filereadable(config_file) == 1 then
			return fullPath
		end
	end
end

function M.prettier()
	if not vim.loop.os_getenv('PRETTIERD_LOCAL_PRETTIER_ONLY') then
		vim.loop.os_setenv('PRETTIERD_LOCAL_PRETTIER_ONLY', 'true')
	end

	local config_files = {
		'.prettierrc',
		'.prettierrc.json',
		'.prettierrc.json5',
		'.prettierrc.yml',
		'.prettierrc.yaml',
		'.prettierrc.js',
		'.prettierrc.cjs',
		'.prettierrc.config.js',
		'.prettierrc.config.cjs',
		'.prettierrc.toml',
	}

	local config = select_config_file(config_files)

	if not (lsp_loaded and config) then
        vim.loop.os_unsetenv('PRETTIERD_DEFAULT_CONFIG')
		vim.cmd('FormatDisable')
		return nil
	end

	vim.cmd('FormatEnable')
	vim.notify(
		string.format(
			'Formatting file with %s config',
			vim.fn.expand(config, ':p:' .. vim.loop.cwd())
		),
		vim.log.levels.INFO
	)

	vim.loop.os_setenv('PRETTIERD_DEFAULT_CONFIG', config)

	return {
		exe = 'prettierd',
		args = { vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

function M.tslint()
	if not vim.fn.filereadable('tslint.json') == 1 then
		return nil
	end

	return {
		exe = 'tslint',
		args = { '-c', 'tslint.json', '--fix', '--force' },
		try_node_modules = true,
		stdin = false,
	}
end

function M.stylua()
	local config = vim.fn.findfile('stylua.toml', vim.loop.cwd() .. '/**')
	local config_path = vim.fn.fnamemodify(config, ':p:.')

	return {
		exe = 'stylua',
		args = {
			'--config-path ' .. config_path,
			'-',
		},
		stdin = true,
	}
end

function M.setup()
	formatter.setup({
		filetype = {
			javascript = {
				M.prettier,
			},
			javascriptreact = {
				M.prettier,
			},
			json = {
				M.prettier,
			},
			lua = {
				M.stylua,
			},
			typescript = {
				M.prettier,
				M.tslint
			},
			typescriptreact = {
				M.prettier,
				M.tslint
			},
		},
	})

	local format_group = session_augroups('Format')
	aucmd('BufWritePost', {
		pattern = { '*.js', '*.cjs', '*.mjs', '*.jsx', '*.ts', '*.tsx', '*.lua' },
		command = 'FormatWrite',
		once = true,
		group = format_group,
	})
end

return M
