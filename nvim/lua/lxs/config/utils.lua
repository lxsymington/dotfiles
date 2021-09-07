local keymap = vim.api.nvim_set_keymap
local api = vim.api
local opt = vim.opt
local M = {}

function M.setup()
	function NumberToggle()
		opt.nu = true

		if opt.rnu then
			opt.rnu = false
		else
			opt.rnu = true
		end
	end

	-- Toggle betwen normal and relative line numbers
	api.nvim_command([[ command! NumberToggle lua NumberToggle() ]])

	function SaveAndExec()
		api.nvim_command('silent! write')

		if opt.filetype == 'vim' then
			api.nvim_command('source $MYVIMRC')
			api.nvim_command('source %')
		elseif opt.filetype == 'lua' then
			api.nvim_command('luafile $MYVIMRC')
			api.nvim_command('luafile %')
		else
			error(string.format('Executing %s files is not supported', opt.filetype))
		end
	end

	-- Save and execute the current file
	api.nvim_command([[ command! SaveAndExec lua SaveAndExec() ]])

	-- Keymap to quickly save and execute
	keymap('n', '<Leader>xf', '<cmd>SaveAndExec<cr>', { silent = true, noremap = true })
end

return M
