local opt = vim.opt
local M = {}

-- External
function M.setup()
	-- Use ripgrep instead of grep
	opt.grepprg = [[rg --vimgrep --no-heading --smart-case]]
	opt.grepformat = [[%f:%l:%c:%m,%f:%l:%m]]

	-- Set the compiler by filetype
	local compiler_augroup = vim.api.nvim_create_augroup('Compiler', {})
	vim.api.nvim_create_autocmd('BufRead', {
	    callback = function ()
            pcall(vim.cmd.compiler, vim.bo.filetype)
        end,
        desc = 'Configure compiler for filetype',
        group = compiler_augroup
    })
end

return M
