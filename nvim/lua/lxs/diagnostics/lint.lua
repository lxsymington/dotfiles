local lint = require('lint')
local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local M = {}

function M.tslint_parser(output, bufnr)
	local tslint_results = vim.json.decode(output)
	local diagnostics = {}

	for _, lint_result in ipairs(tslint_results) do
		table.insert(diagnostics, {
			bufnr = bufnr,
			lnum = lint_result.startPosition.line,
			end_lnum = lint_result.endPosition.line,
			col = lint_result.startPosition.character,
			end_col = lint_result.endPosition.character,
			severity = vim.diagnostic.severity.ERROR,
			message = lint_result.failure,
			source = 'tslint',
			code = lint_result.ruleName,
		})
	end

	return diagnostics
end

function M.setup()
	lint.linters.tslint = {
		cmd = 'tslint',
		stdin = false,
		args = { '--format=json' },
		stream = 'both',
		ignore_exitcode = true,
		parser = M.tslint_parser,
	}

	lint.linters_by_ft = {
		javascript = { 'eslint' },
		javascriptreact = { 'eslint' },
		typescript = { 'eslint' },
		typescriptreact = { 'eslint' },
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
