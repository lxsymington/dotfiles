local nvim_exec = vim.api.nvim_exec
local wk = require('which-key')
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

	wk.register({
		[']'] = {
			name = 'Next',
			t = {
				'<Plug>(ultest-next-fail)',
				'failing test',
			},
		},
		['['] = {
			name = 'Previous',
			t = {
				'<Plug>(ultest-prev-fail)',
				'failing test',
			},
		},
	}, {
		mode = 'n',
		noremap = true,
		silent = true,
	})
end

return M
