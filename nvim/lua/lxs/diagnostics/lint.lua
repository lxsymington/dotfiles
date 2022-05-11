local lint = require('lint')
local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local M = {}

function M.tslint_parser(output, bufnr)
	local json_results = string.match(output, '(.-)\n')
	local tslint_results = vim.json.decode(json_results)
    local severity_map = {
        ['ERROR'] = vim.diagnostic.severity.ERROR,
        ['WARNING'] = vim.diagnostic.severity.WARN,
    }

	local diagnostics = {}

	for _, lint_result in ipairs(tslint_results) do
		table.insert(diagnostics, {
			bufnr = bufnr,
			lnum = lint_result.startPosition.line,
			end_lnum = lint_result.endPosition.line,
			col = lint_result.startPosition.character,
			end_col = lint_result.endPosition.character,
			severity = severity_map[lint_result.ruleSeverity],
			message = lint_result.failure,
			source = 'tslint',
			code = lint_result.ruleName,
		})
	end

	return diagnostics
end

function M.setup()
	lint.linters.tslint = function ()
	    local config = vim.fn.findfile('tsconfig.json', vim.loop.cwd())
	    local args = config and {
	        '--format',
	        'json',
	        '--project',
	        config
	    } or { '--format', 'json' }

	    return {
            cmd = 'tslint',
            stdin = false,
            args = args,
            stream = 'both',
            ignore_exitcode = true,
            parser = M.tslint_parser,
        }
	end

	lint.linters_by_ft = {
		javascript = { 'eslint' },
		javascriptreact = { 'eslint' },
		['javascript.jsx'] = { 'eslint' },
		typescript = { 'eslint', 'tslint' },
		typescriptreact = { 'eslint', 'tslint' },
		['typescript.tsx'] = { 'eslint', 'tslint' },
		lua = { 'selene' },
		vim = { 'vint' },
	}

	local lint_group = augrp('Lint', { clear = true })
	aucmd('BufWritePost', {
		callback = function()
			lint.try_lint()
		end,
		group = lint_group,
	})
end

return M
