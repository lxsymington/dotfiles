local neotest = require('neotest')
local neotest_vim_test = require('neotest-vim-test')
local keymap = vim.keymap
local M = {}

function M.setup()
    neotest.setup({
        strategies = {
            integrated = {
                width = 100
            }
        },
        adapters = {
            neotest_vim_test({
                ignore_file_types = {}
            })
        }
    })

	keymap.set('n', '<Leader>tn', function ()
	    require('neotest').run.run()
	end, {
		desc = 'Test » Nearest',
		silent = true,
	})

	keymap.set('n', '<Leader>tl', function ()
	    require('neotest').run.run_last()
	end, {
		desc = 'Test » Last',
		silent = true,
	})

	keymap.set('n', '<Leader>tf', function ()
	    require('neotest').run.run(vim.fn.expand('%'))
	end, {
		desc = 'Test » Current File',
		silent = true,
	})

	keymap.set('n', '<Leader>td', function ()
	    require('neotest').run.run({ strategy = 'dap' })
	end, {
		desc = 'Test » Debug Nearest',
		silent = true,
	})

	keymap.set('n', '<Leader>t!', function ()
	    require('neotest').run.stop()
	end, {
		desc = 'Test » Stop',
		silent = true,
	})

	keymap.set('n', '<Leader>ts', function ()
	    require('neotest').summary.toggle()
	end, {
		desc = 'Test » Summary',
		silent = true,
	})

	keymap.set('n', '<Leader>to', function ()
	    require('neotest').output.open()
	end, {
		desc = 'Test » Output',
		silent = true,
	})

	keymap.set('n', '<Leader>ta', function ()
	    require('neotest').run.attach()
	end, {
		desc = 'Test » Attach',
		silent = true,
	})

	keymap.set('n', ']t', function ()
	   require('neotest').jump.next({ status = 'failed' })
	end, {
		desc = 'Next » Failing Test',
		silent = true,
	})

	keymap.set('n', '[t', function ()
	   require('neotest').jump.prev({ status = 'failed' })
	end, {
		desc = 'Previous » Failing Test',
		silent = true,
	})
end

return M
