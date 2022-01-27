local gitsigns = require('gitsigns')
local wk = require('which-key')
local M = {}

-- GITSIGNS ----------------------------
function M.setup()
	gitsigns.setup({
		signs = {
			add = { hl = 'GitSignsAddSign', text = '│', numhl = 'GitSignsAddNr' },
			change = { hl = 'GitSignsChangeSign', text = '┊', numhl = 'GitSignsChangeNr' },
			delete = { hl = 'GitSignsDeleteSign', text = '┴', numhl = 'GitSignsDeleteNr' },
			topdelete = { hl = 'GitSignsDeleteSign', text = '┬', numhl = 'GitSignsDeleteNr' },
			changedelete = {
				hl = 'GitSignsChangeSign',
				text = '├',
				numhl = 'GitSignsChangeNr',
			},
		},
		numhl = true,
		current_line_blame = true,
		current_line_blame_opts = {
            virt_text_pos = 'right_align',
        },
        current_line_blame_formatter_opts = {
            relative_time = true
        },
        preview_config = {
            border = 'rounded',
        },
        on_attach = function (bufnr)
            wk.register({
                [']'] = {
                    name = 'Next',
                    c = {
                        '&diff ? "]c" : "<Cmd>Gitsigns next_hunk<CR>"',
                        'Git hunk',
                        expr = true
                    }
                },
                ['['] = {
                    name = 'Previous',
                    c = {
                        '&diff ? "[c" : "<Cmd>Gitsigns prev_hunk<CR>"',
                        'Git hunk',
                        expr = true
                    }
                },
                ['<Leader>'] = {
                    h = {
                        name = 'GitSigns',
                        s = {
                            '<Cmd>Gitsigns stage_hunk<CR>',
                            'Stage hunk'
                        },
                        r = {
                            '<Cmd>Gitsigns reset_hunk<CR>',
                            'Reset hunk'
                        },
                        S = {
                            '<Cmd>Gitsigns stage_buffer<CR>',
                            'Stage buffer'
                        },
                        u = {
                            '<Cmd>Gitsigns undo_stage_buffer<CR>',
                            'Undo stage buffer'
                        },
                        R = {
                            '<Cmd>Gitsigns reset_buffer<CR>',
                            'Reset buffer'
                        },
                        p = {
                            '<Cmd>Gitsigns preview_hunk<CR>',
                            'Preview hunk'
                        },
                        b = {
                            '<Cmd>lua require("gitsigns").blame_line({full=true})<CR>',
                            'Show full line blame'
                        },
                        d = {
                            '<Cmd>Gitsigns diffthis<CR>',
                            'Diff file'
                        },
                        D = {
                            '<Cmd>lua require"gitsigns".diffthis("~")<CR>',
                            'Diff project'
                        },
                    },
                    t = {
                        b = {
                            '<Cmd>Gitsigns toggle_current_line_blame<CR>',
                            'Toggle line blame'
                        },
                        d = {
                            '<Cmd>Gitsigns toggle_deleted<CR>',
                            'Toggle deleted'
                        }
                    }
                }
            }, {
                mode = 'n',
                buffer = bufnr,
                silent = true,
                noremap = true
            })
            wk.register({
                ['<Leader>'] = {
                    h = {
                        name = 'GitSigns',
                        s = {
                            '<Cmd>Gitsigns stage_hunk<CR>',
                            'Stage hunk'
                        },
                        r = {
                            '<Cmd>Gitsigns reset_hunk<CR>',
                            'Reset hunk'
                        },
                    },
                }
            }, {
                mode = 'v',
                buffer = bufnr,
                silent = true,
                noremap = true
            })
            wk.register({
                i = {
                    h = {
                        ':<C-U>Gitsigns select_hunk<CR>',
                        'GitSigns hunk'
                    },
                }
            }, {
                mode = 'o',
                buffer = bufnr,
                silent = true,
                noremap = true
            })
            wk.register({
                i = {
                    h = {
                        ':<C-U>Gitsigns select_hunk<CR>',
                        'GitSigns hunk'
                    },
                }
            }, {
                mode = 'x',
                buffer = bufnr,
                silent = true,
                noremap = true
            })
        end
    })
end

return M
