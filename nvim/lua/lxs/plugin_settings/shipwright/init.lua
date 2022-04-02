local api = vim.api
local lush = require('lush')

local M = {}

function M.shipwright_build(should_set_colourscheme)
	if should_set_colourscheme then
		lush(require(vim.g.colors_name))
	end

	vim.cmd('Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/build.lua')
end

function M.setup()
	lush(require(vim.g.colors_name))

	api.nvim_command(
		[[ command! ApplyColourscheme lua require('lxs.plugin_settings.shipwright').shipwright_build(true) ]]
	)

	api.nvim_create_augroup('Shipwright', { clear = true })
	api.nvim_create_autocmd('VimEnter', {
		callback = function()
			M.shipwright_build(false)
		end,
	})
	api.nvim_create_autocmd('BufWritePost', {
		pattern = string.format('*/%s/**', vim.g.colors_name),
		callback = function()
			M.shipwright_build(true)
		end,
	})
end

return M
