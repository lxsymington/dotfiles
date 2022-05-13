local refactoring = require('refactoring')
local wk = require('which-key')
local M = {}

function M.setup()
    refactoring.setup({})

    wk.register({
        ['<Leader>'] = {
            a = {
                name = 'Analysis',
                r = {
                    name = 'Refactor',
                    e = {
                        name = 'Extract',
                        f = {
                            [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
                            'Function'
                        },
                        F = {
                            [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
                            'Function to file'
                        },
                        v = {
                            [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
                            'Variable'
                        }
                    },
                    i = {
                        name = 'Inline',
                        v = {
                            [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
                            'Variable'
                        }
                    },
                    s = {
                        [[ <Cmd>lua require('refactoring').select_refactor()<CR>]],
                        'Select'
                    }
                }
            }
        }
    }, { mode = 'v', noremap = true, silent = true, expr = false })

    wk.register({
        ['<Leader>'] = {
            a = {
                name = 'Analysis',
                r = {
                    name = 'Refactor',
                    e = {
                        name = 'Extract',
                        b = {
                            [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
                            'Block'
                        },
                        B = {
                            [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
                            'Block to file'
                        }
                    },
                    i = {
                        name = 'Inline',
                        v = {
                            [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
                            'Variable'
                        }
                    }
                }
            }
        }
    }, { mode = 'n', noremap = true, silent = true, expr = false })
end

return M
