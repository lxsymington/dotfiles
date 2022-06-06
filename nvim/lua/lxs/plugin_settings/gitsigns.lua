local gitsigns = require('gitsigns')
local keymap = vim.keymap
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
			virt_text_pos = 'eol',
		},
		current_line_blame_formatter_opts = {
			relative_time = true,
		},
		preview_config = {
			border = 'rounded',
		},
		on_attach = function(bufnr)
		    keymap.set('n', ']c', '&diff ? "]c" : "<Cmd>Gitsigns next_hunk<CR>"', {
		        buffer = bufnr,
		        desc = 'Next » Git Hunk',
		        expr = true,
		        silent = true,
		    })
		    keymap.set('n', '[c', '&diff ? "[c" : "<Cmd>Gitsigns prev_hunk<CR>"', {
		        buffer = bufnr,
		        desc = 'Previous » Git Hunk',
		        expr = true,
		        silent = true,
		    })
		    keymap.set({'n', 'v'}, '<Leader>hs', '<Cmd>Gitsigns stage_hunk<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Stage Hunk',
		        silent = true,
		    })
		    keymap.set('n', '<Leader>hu', '<Cmd>Gitsigns undo_stage_hunk<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Undo Stage Hunk',
		        silent = true,
		    })
		    keymap.set({'n', 'v'}, '<Leader>hr', '<Cmd>Gitsigns reset_hunk<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Reset Hunk',
		        silent = true,
		    })
		    keymap.set('n', '<Leader>hp', '<Cmd>Gitsigns preview_hunk<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Preview Hunk',
		        silent = true,
		    })
            keymap.set('n', '<Leader>hb', function ()
                require("gitsigns").blame_line({full=true})
            end, {
                buffer = bufnr,
                desc = 'GitSigns » Show full line blame',
            })
            keymap.set('n', '<Leader>hd', '<Cmd>Gitsigns diffthis<CR>', {
                buffer = bufnr,
                desc = 'GitSigns » Diff File',
            })
		    keymap.set('n', '<Leader>hS', '<Cmd>Gitsigns stage_buffer<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Stage Buffer',
		        silent = true,
		    })
		    keymap.set('n', '<Leader>hU', '<Cmd>Gitsigns undo_stage_buffer<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Undo Stage Buffer',
		        silent = true,
		    })
		    keymap.set('n', '<Leader>hR', '<Cmd>Gitsigns reset_buffer<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Stage Buffer',
		        silent = true,
		    })
		    keymap.set('n', '<Leader>hD', function ()
                require"gitsigns".diffthis("~")
		    end, { silent = true, desc = 'GitSigns » Diff Project' })
		    keymap.set('n', '<Leader>tb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Toggle Line Blame',
		        silent = true,
		    })
		    keymap.set('n', '<Leader>td', '<Cmd>Gitsigns toggle_deleted<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » Toggle Deleted',
		        silent = true,
		    })
		    keymap.set({'o', 'x'}, 'ih', '<Cmd><C-U>Gitsigns select_hunk<CR>', {
		        buffer = bufnr,
		        desc = 'GitSigns » GitSigns Hunk',
		        silent = true,
		    })
		end,
	})
end

return M
