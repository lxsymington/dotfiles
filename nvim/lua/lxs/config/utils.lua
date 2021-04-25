local keymap = vim.api.nvim_set_keymap
local api = vim.api
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local M = {}

function M.setup()
	function NumberToggle()
		o.nu = true

		if wo.rnu then
			wo.rnu = false
		else
			wo.rnu = true
		end
	end

	-- Toggle betwen normal and relative line numbers
	api.nvim_command([[ command! NumberToggle lua NumberToggle() ]])

	function SaveAndExec()
		api.nvim_command("silent! write")

		if bo.filetype == "vim" then
			api.nvim_command("source $MYVIMRC")
			api.nvim_command("source %")
		elseif bo.filetype == "lua" then
			api.nvim_command("luafile $MYVIMRC")
			api.nvim_command("luafile %")
		else
			error(string.format("Executing %s files is not supported", bo.filetype))
		end
	end

	-- Save and execute the current file
	api.nvim_command([[ command! SaveAndExec lua SaveAndExec() ]])

	-- Keymap to quickly save and execute
	keymap("n", "<Leader>xf", "<cmd>SaveAndExec<cr>", { silent = true, noremap = true })
end

return M
