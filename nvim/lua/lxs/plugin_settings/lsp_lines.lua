local M = {}

local enabled = false

function M.setup()
	vim.diagnostic.config({ virtual_text = enabled })
	require('lsp_lines').setup()

	vim.keymap.set('n', '<Leader>ll', function()
		enabled = not enabled
		if enabled == true then
			vim.diagnostic.config({
				virtual_text = {
					prefix = '●',
					source = 'always',
				},
			})
		else
			vim.diagnostic.config({
				virtual_text = false,
			})
		end
		require('lsp_lines').toggle()
	end, {
		desc = 'Toggle lsp_lines',
	})
end

return M
