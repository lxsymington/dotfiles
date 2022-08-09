local neotest = require('neotest')
local neotest_vim_test = require('neotest-vim-test')
local keymap = vim.keymap
local M = {}

function M.setup()
    neotest.setup({
        adapters = {
            require('neotest-jest')({
                jestCommand = "npm test --",
            }),
            neotest_vim_test({
                ignore_file_types = { 'typescript' }
            })
        },
        diagnostic = {
            enabled = true
        },
        discovery = {
            enabled = true
        },
        icons = {
            failed = "✘",
            passed = "✔",
            running = "➜",
            skipped = "⭕",
            unknown = "❓"
        },
        jump = {
            enabled = true
        },
        output = {
            enabled = true,
            open_on_run = true
        },
        run = {
            enabled = true
        },
        status = {
            enabled = true,
            signs = true,
            virtual_text = true
        },
        strategies = {
            integrated = {
                width = 100
            }
        },
        summary = {
            enabled = true,
            expand_errors = true,
            follow = true,
            mappings = {
                attach = "a",
                clear_marked = "M",
                expand = { "<CR>", "<2-LeftMouse>" },
                expand_all = "e",
                jumpto = "i",
                mark = "m",
                output = "o",
                run = "r",
                run_marked = "R",
                short = "O",
                stop = "u"
            },
            width = 80,
        }
    })

    keymap.set('n', '<Leader>tn', function()
        require('neotest').run.run()
    end, {
        desc = 'Test » Nearest',
        silent = true,
    })

    keymap.set('n', '<Leader>tl', function()
        require('neotest').run.run_last()
    end, {
        desc = 'Test » Last',
        silent = true,
    })

    keymap.set('n', '<Leader>tf', function()
        require('neotest').run.run(vim.fn.expand('%'))
    end, {
        desc = 'Test » Current File',
        silent = true,
    })

    keymap.set('n', '<Leader>td', function()
        require('neotest').run.run({ strategy = 'dap' })
    end, {
        desc = 'Test » Debug Nearest',
        silent = true,
    })

    keymap.set('n', '<Leader>t!', function()
        require('neotest').run.stop()
    end, {
        desc = 'Test » Stop',
        silent = true,
    })

    keymap.set('n', '<Leader>ts', function()
        require('neotest').summary.toggle()
    end, {
        desc = 'Test » Summary',
        silent = true,
    })

    keymap.set('n', '<Leader>to', function()
        require('neotest').output.open()
    end, {
        desc = 'Test » Output',
        silent = true,
    })

    keymap.set('n', '<Leader>ta', function()
        require('neotest').run.attach()
    end, {
        desc = 'Test » Attach',
        silent = true,
    })

    keymap.set('n', ']t', function()
        require('neotest').jump.next({ status = 'failed' })
    end, {
        desc = 'Next » Failing Test',
        silent = true,
    })

    keymap.set('n', '[t', function()
        require('neotest').jump.prev({ status = 'failed' })
    end, {
        desc = 'Previous » Failing Test',
        silent = true,
    })
end

return M
