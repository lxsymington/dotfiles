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
	if not lsp_loaded then
		return nil
	end

	local prettier_config_files = {
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

	local eslint_config_files = {
	    '.eslintrc.js',
	    '.eslintrc.cjs',
	    '.eslintrc.yml',
	    '.eslintrc.yaml',
	    '.eslintrc.json'
	}

	local prettier_config = select_config_file(prettier_config_files)
	local eslint_config = select_config_file(eslint_config_files)

	local relative_prettier_config = vim.fn.fnamemodify(prettier_config, ':.')
	local relative_eslint_config = vim.fn.fnamemodify(eslint_config, ':.')

	if not (relative_prettier_config or relative_eslint_config) then
		vim.cmd.FormatDisable()
		return nil
	end

	vim.cmd.FormatEnable()

	vim.notify(
		string.format(
		    'Formatting file:\n\tESLint config: %s\n\tPrettier config: %s',
		    relative_eslint_config,
		    relative_prettier_config
		),
		vim.log.levels.INFO,
		{
			title = 'Formatter',
		}
	)

	return {
		exe = 'prettier-eslint',
		args = {
		    string.format('--config %s', relative_prettier_config),
		    string.format('--eslint-config-path', relative_eslint_config),
		    '--stdin',
		    string.format('--stdin-filepath %s', vim.api.nvim_buf_get_name(0)),
		},
		cwd = vim.loop.cwd(),
		stdin = true,
		try_node_modules = true,
	}
end

function M.tslint()
	if vim.fn.filereadable('tslint.json') == 0 then
		return nil
	end

	vim.notify('Formatting file with `tslint.json` config', vim.log.levels.INFO, {
		title = 'Formatter',
	})

	return {
		exe = 'tslint',
		args = { '-c tslint.json', '--fix', '--force' },
		stdin = false,
		try_node_modules = true,
	}
end

function M.stylua()
	local config = vim.fn.findfile('stylua.toml', vim.loop.cwd() .. '/**')
	local config_path = vim.fn.fnamemodify(config, ':p:.')

	vim.notify(string.format('Formatting file with %s config', config_path), vim.log.levels.INFO, {
		title = 'Formatter',
	})

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
				M.tslint,
			},
			typescriptreact = {
				M.prettier,
				M.tslint,
			},
		},
	})

	local format_group = session_augroups('Format')
	aucmd('BufWritePost', {
		pattern = {
			'*.js',
			'*.cjs',
			'*.mjs',
			'*.jsx',
			'*.ts',
			'*.tsx',
			'*.json',
			'*.jsonc',
			'*.lua',
		},
		command = 'FormatWrite',
		once = true,
		group = format_group,
	})
end

return M
