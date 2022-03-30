local colours = require(vim.g.colors_name .. '.colours')
local feline = require('feline')
local lsp = require('feline.providers.lsp')
local devicons = require('nvim-web-devicons')
local lsp_status = require('lsp-status')
local fn = vim.fn
local api = vim.api
local bo = vim.bo
local b = vim.b
local M = {}

local mode_alias_map = {
	[''] = {
		name = 'Select-Block',
		fg = colours.black.hex,
		bg = colours.lightPurple.hex,
	},
	[''] = {
		name = 'Visual-Block',
		fg = colours.black.hex,
		bg = colours.lightCyan.hex,
	},
	['!'] = { name = 'Shell', fg = colours.black.hex, bg = colours.lightBlue.hex },
	['no'] = {
		name = 'Operator-Pending',
		fg = colours.black.hex,
		bg = colours.lightGrey.hex,
	},
	['r?'] = { name = 'Confirm', fg = colours.black.hex, bg = colours.grey.hex },
	c = { name = 'Command-Line', fg = colours.black.hex, bg = colours.orange.hex },
	ce = {
		name = 'Normal-Ex',
		fg = colours.black.hex,
		bg = colours.lightOrange.hex,
	},
	cv = { name = 'Vim-Ex', fg = colours.black.hex, bg = colours.lightOrange.hex },
	i = { name = 'Insert', fg = colours.black.hex, bg = colours.green.hex },
	ic = {
		name = 'Insert-Completion',
		fg = colours.black.hex,
		bg = colours.lightGreen.hex,
	},
	ix = {
		name = 'Insert-Completion',
		fg = colours.black.hex,
		bg = colours.lightGreen.hex,
	},
	n = { name = 'Normal', fg = colours.black.hex, bg = colours.yellow.hex },
	niI = {
		name = 'Normal-Insert',
		fg = colours.black.hex,
		bg = colours.lightYellow.hex,
	},
	niR = {
		name = 'Normal-Replace',
		fg = colours.black.hex,
		bg = colours.lightYellow.hex,
	},
	niV = {
		name = 'Normal-Virtual-Replace',
		fg = colours.black.hex,
		bg = colours.lightYellow.hex,
	},
	no = {
		name = 'Operator-Pending',
		fg = colours.black.hex,
		bg = colours.lightGrey.hex,
	},
	noV = {
		name = 'Operator-Pending',
		fg = colours.black.hex,
		bg = colours.lightGrey.hex,
	},
	nov = {
		name = 'Operator-Pending',
		fg = colours.black.hex,
		bg = colours.lightGrey.hex,
	},
	r = { name = 'Hit-Enter', fg = colours.black.hex, bg = colours.grey.hex },
	R = { name = 'Replace', fg = colours.black.hex, bg = colours.red.hex },
	Rc = {
		name = 'Replace-Completion',
		fg = colours.black.hex,
		bg = colours.lightRed.hex,
	},
	rm = { name = '-- More --', fg = colours.black.hex, bg = colours.grey.hex },
	Rv = {
		name = 'Virtual-Replace',
		fg = colours.black.hex,
		bg = colours.lightRed.hex,
	},
	Rx = {
		name = 'Replace-Completion',
		fg = colours.black.hex,
		bg = colours.lightRed.hex,
	},
	s = { name = 'Select', fg = colours.black.hex, bg = colours.purple.hex },
	S = {
		name = 'Select-Line',
		fg = colours.black.hex,
		bg = colours.lightPurple.hex,
	},
	t = { name = 'Terminal', fg = colours.black.hex, bg = colours.blue.hex },
	v = { name = 'Visual', fg = colours.black.hex, bg = colours.cyan.hex },
	V = {
		name = 'Visual-Line',
		fg = colours.black.hex,
		bg = colours.lightCyan.hex,
	},
}

local vi_mode = function()
	local mode = fn.mode()
	local mode_alias = string.upper(mode_alias_map[mode].name)

	return string.format('  %s ', mode_alias)
end

local file_namer = function()
	local file_path = fn.expand('%:p')

	if fn.empty(file_path) == 1 then
		return ''
	end

	local file_icon = devicons.get_icon(
		fn.fnamemodify(file_path, ':t'),
		fn.fnamemodify(file_path, ':e'),
		{ default = true }
	)
	local relative_file_path = fn.fnamemodify(file_path, ':~:.')
	local short_file_path = #relative_file_path < api.nvim_win_get_width(0) / 3
			and relative_file_path
		or fn.pathshorten(relative_file_path)
	local file_info = string.format(' %s %s ', file_icon, short_file_path)

	if bo.modified then
		file_info = string.format('%s %s ', file_info, '')
	end

	if not bo.modifiable then
		file_info = string.format('%s %s ', file_info, '')
	end

	return file_info
end

local buffer_not_empty = function()
	return fn.empty(fn.expand('%:t')) ~= 1
end

--[[
    Feline Separators

    block = '█',
    circle = '●'
    left = '',
    left_filled = '',
    left_rounded = '',
    left_rounded_thin = '',
    right = '',
    right_filled = '',
    right_rounded = '',
    right_rounded_thin = '',
    slant_left = '',
    slant_left_2 = '',
    slant_left_2_thin = '',
    slant_left_thin = '',
    slant_right = '',
    slant_right_2 = '',
    slant_right_2_thin = '',
    slant_right_thin = '',
    vertical_bar = '┃',
    vertical_bar_thin = '│',
]]

-- FELINE ------------------------------
function M.setup()
	local components = {
		active = {
			{},
			{},
			{},
		},
		inactive = {
			{},
			{},
			{},
		},
	}

	--[[ local force_inactive = {
	  filetypes = {
		'NvimTree',
		'dbui',
		'packer',
		'startify',
		'fugitive',
		'fugitiveblame',
      },
      buftypes = { 'terminal' }
	} ]]

	table.insert(components.active[1], {
		provider = file_namer,
		enabled = buffer_not_empty,
		hl = {
			fg = colours.white.hex,
			bg = colours.lightBlack.hex,
			style = 'bold',
		},
		left_sep = { 'block' },
	})

	table.insert(components.active[1], {
		provider = 'file_size',
		enabled = buffer_not_empty,
		hl = {
			fg = colours.lightGrey.hex,
			bg = colours.lightBlack.hex,
			style = 'italic',
		},
		left_sep = {
			{
				str = 'vertical_bar',
				hl = { fg = colours.orange.hex, bg = colours.lightBlack.hex },
			},
			{ str = ' ', hl = { fg = 'NONE', bg = colours.lightBlack.hex } },
		},
		right_sep = { str = ' ', hl = { fg = 'NONE', bg = colours.lightBlack.hex } },
	})

	table.insert(components.active[1], {
		provider = 'git_branch',
		hl = {
			fg = colours.lightWhite.hex,
			bg = colours.blue.hex,
			style = 'bold',
		},
		left_sep = { 'block' },
		right_sep = function()
			return {
				str = 'right_rounded',
				hl = {
					fg = b.gitsigns_status_dict and colours.blue.hex or colours.lightBlack.hex,
				},
			}
		end,
	})

	table.insert(components.active[1], {
		provider = 'git_diff_added',
		hl = { fg = colours.green.hex },
	})

	table.insert(components.active[1], {
		provider = 'git_diff_changed',
		hl = { fg = colours.orange.hex },
	})

	table.insert(components.active[1], {
		provider = 'git_diff_removed',
		hl = { fg = colours.red.hex },
	})

	table.insert(components.active[2], {
		provider = '%n',
		hl = { fg = colours.lightWhite.hex, bg = colours.purple.hex, style = 'bold' },
		left_sep = { 'left_rounded_thin', 'left_rounded' },
		right_sep = { 'block' },
	})

	table.insert(components.active[2], {
		provider = vi_mode,
		hl = function()
			local mode = fn.mode()

			return {
				name = string.gsub(mode_alias_map[mode].name, '(%a+)', 'FelineViModeHighlight%1'),
				fg = mode_alias_map[mode].fg,
				bg = mode_alias_map[mode].bg,
				style = 'bold',
			}
		end,
		right_sep = { 'right_rounded', 'right_rounded_thin' },
	})

	table.insert(components.active[3], {
		provider = function()
			return lsp_status.status()
		end,
		enabled = function()
			return #vim.lsp.buf_get_clients() > 0
		end,
		hl = { fg = colours.lightGrey.hex },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_errors',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.Error)
		end,
		hl = { fg = colours.red.hex },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_warnings',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
		end,
		hl = { fg = colours.yellow.hex },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_hints',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
		end,
		hl = { fg = colours.cyan.hex },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_info',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
		end,
		hl = { fg = colours.lightBlue.hex },
	})

	table.insert(components.active[3], {
		provider = 'position',
		left_sep = {
			{
				str = ' ',
				hl = { fg = 'NONE' },
			},
			{
				str = 'left_rounded',
				hl = { fg = colours.lightPurple.hex },
			},
			{
				str = 'left_rounded_thin',
				hl = { bg = colours.lightPurple.hex, fg = 'bg' },
			},
			{
				str = 'left_rounded',
				hl = { bg = colours.lightPurple.hex, fg = 'bg' },
			},
			{
				str = '  ',
				hl = { fg = colours.purple.hex },
			},
		},
		right_sep = {
			{
				str = '  ',
				hl = { fg = colours.purple.hex },
			},
			{
				str = 'right_rounded',
				hl = {
					bg = colours.lightPurple.hex,
					fg = 'bg',
				},
			},
			{
				str = 'right_rounded_thin',
				hl = {
					bg = colours.lightPurple.hex,
					fg = 'bg',
				},
			},
		},
		hl = { fg = colours.lightGrey.hex },
	})

	table.insert(components.active[3], {
		provider = 'line_percentage',
		hl = {
			bg = colours.lightPurple.hex,
			fg = 'bg',
			style = 'bold',
		},
		left_sep = {
			str = ' ',
			hl = {
				bg = colours.lightPurple.hex,
				fg = 'NONE',
			},
		},
		right_sep = {
			str = ' ',
			hl = {
				bg = colours.lightPurple.hex,
				fg = 'NONE',
			},
		},
	})

	table.insert(components.active[3], {
		provider = 'scroll_bar',
		hl = {
			bg = colours.purple.hex,
			fg = colours.black.hex,
			style = 'bold',
		},
	})

	table.insert(components.inactive[1], {
		provider = file_namer,
		enabled = buffer_not_empty,
		hl = {
			fg = colours.white.hex,
			bg = colours.lightBlack.hex,
			style = 'bold',
		},
		left_sep = { 'block' },
	})

	table.insert(components.inactive[3], {
		provider = 'file_type',
		hl = { fg = colours.white.hex, bg = colours.blue.hex, style = 'bold' },
		left_sep = {
			'left_rounded',
			{ str = ' ', hl = { fg = 'NONE', bg = colours.blue.hex } },
		},
		right_sep = { str = ' ', hl = { fg = 'NONE', bg = colours.blue.hex } },
	})

	feline.setup({
		colors = {
			bg = api.nvim_get_option('background') == 'dark' and colours.black.hex
				or colours.lightWhite.hex,
			fg = api.nvim_get_option('background') == 'dark' and colours.white.hex
				or colours.lightBlack.hex,
		},
		components = components,
	})
end

return M
