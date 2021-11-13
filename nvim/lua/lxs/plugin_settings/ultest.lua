local nvim_exec = vim.api.nvim_exec
local keymap = vim.api.nvim_set_keymap
local g = vim.g
local M = {}

-- Ultest ------------------------------
function M.setup()
	g.ultest_max_threads = 4
	g.ultest_use_pty = 1
	g.ultest_virtual_text = 1
	g.ultest_pass_sign = ''
	g.ultest_fail_sign = '﮻'
	g.ultest_running_sign = ''
	g.ultest_not_run_sign = ''
	g.ultest_pass_text = ''
	g.ultest_fail_text = '﮻'
	g.ultest_running_text = ''

	nvim_exec(
		[[
            augroup UltestRunner
            autocmd!
            autocmd BufWritePost * UltestNearest
            augroup END
        ]],
		false
	)

	local keymap_opts = { noremap = true, silent = true }

	keymap('n', ']t', '<Plug>(ultest-next-fail)', keymap_opts)
	keymap('n', '[t', '<Plug>(ultest-prev-fail)', keymap_opts)
end

return M
