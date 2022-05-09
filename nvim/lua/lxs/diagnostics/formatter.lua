local formatter = require('formatter')
local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local M = {}

--[[ local configFiles = {
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
} ]]

--[[ for _, configFile in ipairs(configFiles) do
    local fullPath = util.path.join(project_dir, configFile)

    if util.path.is_file(fullPath) then
        return true
    end
end

return false ]]

function M.prettier()
	return {
		exe = 'prettierd',
		args = { vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

function M.stylua()
	local config = vim.fn.findfile('stylua.toml', vim.loop.cwd() .. '/**')

	return {
		exe = 'stylua',
		args = {
			'--config-path ' .. config,
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
			json = {
				M.prettier,
			},
			lua = {
				M.stylua,
			},
		},
	})

	local format_group = augrp('Format', { clear = true })
	aucmd('BufWritePost', {
		pattern = { '*.js', '*.cjs', '*.mjs', '*.jsx', '*.ts', '*.tsx', '*.lua' },
		command = 'FormatWrite',
		group = format_group,
	})
end

return M
