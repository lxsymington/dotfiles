local theme = require('lxs.plugin_settings.shipwright.theme').current
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
		fg = theme.black,
		bg = theme.magenta_alt,
	},
	[''] = {
		name = 'Visual-Block',
		fg = theme.foreground,
		bg = theme.cyan_alt,
	},
	['!'] = { name = 'Shell', fg = theme.foreground, bg = theme.blue_alt },
	['no'] = {
		name = 'Operator-Pending',
		fg = theme.foreground,
		bg = theme.grey_alt,
	},
	['r?'] = { name = 'Confirm', fg = theme.foreground, bg = theme.grey },
	c = { name = 'Command-Line', fg = theme.foreground, bg = theme.orange },
	ce = {
		name = 'Normal-Ex',
		fg = theme.foreground,
		bg = theme.orange_alt,
	},
	cv = { name = 'Vim-Ex', fg = theme.foreground, bg = theme.orange_alt },
	i = { name = 'Insert', fg = theme.foreground, bg = theme.green },
	ic = {
		name = 'Insert-Completion',
		fg = theme.foreground,
		bg = theme.green_alt,
	},
	ix = {
		name = 'Insert-Completion',
		fg = theme.foreground,
		bg = theme.green_alt,
	},
	n = { name = 'Normal', fg = theme.foreground, bg = theme.yellow },
	niI = {
		name = 'Normal-Insert',
		fg = theme.foreground,
		bg = theme.yellow_alt,
	},
	niR = {
		name = 'Normal-Replace',
		fg = theme.foreground,
		bg = theme.yellow_alt,
	},
	niV = {
		name = 'Normal-Virtual-Replace',
		fg = theme.foreground,
		bg = theme.yellow_alt,
	},
	no = {
		name = 'Operator-Pending',
		fg = theme.foreground,
		bg = theme.grey_alt,
	},
	noV = {
		name = 'Operator-Pending',
		fg = theme.foreground,
		bg = theme.grey_alt,
	},
	nov = {
		name = 'Operator-Pending',
		fg = theme.foreground,
		bg = theme.grey_alt,
	},
	r = { name = 'Hit-Enter', fg = theme.foreground, bg = theme.grey },
	R = { name = 'Replace', fg = theme.foreground, bg = theme.red },
	Rc = {
		name = 'Replace-Completion',
		fg = theme.foreground,
		bg = theme.red_alt,
	},
	rm = { name = '-- More --', fg = theme.foreground, bg = theme.grey },
	Rv = {
		name = 'Virtual-Replace',
		fg = theme.foreground,
		bg = theme.red_alt,
	},
	Rx = {
		name = 'Replace-Completion',
		fg = theme.foreground,
		bg = theme.red_alt,
	},
	s = { name = 'Select', fg = theme.foreground, bg = theme.magenta },
	S = {
		name = 'Select-Line',
		fg = theme.foreground,
		bg = theme.magenta_alt,
	},
	t = { name = 'Terminal', fg = theme.foreground, bg = theme.blue },
	v = { name = 'Visual', fg = theme.foreground, bg = theme.cyan },
	V = {
		name = 'Visual-Line',
		fg = theme.foreground,
		bg = theme.cyan_alt,
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
			fg = theme.white,
			bg = theme.background_alt,
			style = 'bold',
		},
		left_sep = { 'block' },
	})

	table.insert(components.active[1], {
		provider = 'file_size',
		enabled = buffer_not_empty,
		hl = {
			fg = theme.grey_alt,
			bg = theme.background_alt,
			style = 'italic',
		},
		left_sep = {
			{
				str = 'vertical_bar',
				hl = { fg = theme.orange, bg = theme.background_alt },
			},
			{ str = ' ', hl = { fg = 'NONE', bg = theme.background_alt } },
		},
		right_sep = { str = ' ', hl = { fg = 'NONE', bg = theme.background_alt } },
	})

	table.insert(components.active[1], {
		provider = 'git_branch',
		hl = {
			fg = theme.white_alt,
			bg = theme.blue,
			style = 'bold',
		},
		left_sep = { 'block' },
		right_sep = function()
			return {
				str = 'right_rounded',
				hl = {
					fg = b.gitsigns_status_dict and theme.blue or theme.background_alt,
				},
			}
		end,
	})

	table.insert(components.active[1], {
		provider = 'git_diff_added',
		hl = { fg = theme.green },
	})

	table.insert(components.active[1], {
		provider = 'git_diff_changed',
		hl = { fg = theme.orange },
	})

	table.insert(components.active[1], {
		provider = 'git_diff_removed',
		hl = { fg = theme.red },
	})

	table.insert(components.active[2], {
		provider = '%n',
		hl = { fg = theme.white_alt, bg = theme.magenta, style = 'bold' },
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
		hl = { fg = theme.grey_alt },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_errors',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.Error)
		end,
		hl = { fg = theme.red },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_warnings',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
		end,
		hl = { fg = theme.yellow },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_hints',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
		end,
		hl = { fg = theme.cyan },
	})

	table.insert(components.active[3], {
		provider = 'diagnostic_info',
		enabled = function()
			return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
		end,
		hl = { fg = theme.blue_alt },
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
				hl = { fg = theme.magenta_alt },
			},
			{
				str = 'left_rounded_thin',
				hl = { bg = theme.magenta_alt, fg = 'bg' },
			},
			{
				str = 'left_rounded',
				hl = { bg = theme.magenta_alt, fg = 'bg' },
			},
			{
				str = '  ',
				hl = { fg = theme.magenta },
			},
		},
		right_sep = {
			{
				str = '  ',
				hl = { fg = theme.magenta },
			},
			{
				str = 'right_rounded',
				hl = {
					bg = theme.magenta_alt,
					fg = 'bg',
				},
			},
			{
				str = 'right_rounded_thin',
				hl = {
					bg = theme.magenta_alt,
					fg = 'bg',
				},
			},
		},
		hl = { fg = theme.grey_alt },
	})

	table.insert(components.active[3], {
		provider = 'line_percentage',
		hl = {
			bg = theme.magenta_alt,
			fg = 'bg',
			style = 'bold',
		},
		left_sep = {
			str = ' ',
			hl = {
				bg = theme.magenta_alt,
				fg = 'NONE',
			},
		},
		right_sep = {
			str = ' ',
			hl = {
				bg = theme.magenta_alt,
				fg = 'NONE',
			},
		},
	})

	table.insert(components.active[3], {
		provider = 'scroll_bar',
		hl = {
			bg = theme.magenta,
			fg = theme.foreground,
			style = 'bold',
		},
	})

	table.insert(components.inactive[1], {
		provider = file_namer,
		enabled = buffer_not_empty,
		hl = {
			fg = theme.white,
			bg = theme.background_alt,
			style = 'bold',
		},
		left_sep = { 'block' },
	})

	table.insert(components.inactive[3], {
		provider = 'file_type',
		hl = { fg = theme.white, bg = theme.blue, style = 'bold' },
		left_sep = {
			'left_rounded',
			{ str = ' ', hl = { fg = 'NONE', bg = theme.blue } },
		},
		right_sep = { str = ' ', hl = { fg = 'NONE', bg = theme.blue } },
	})

	feline.setup({
		colors = {
			bg = theme.background,
			fg = theme.foreground,
		},
		components = components,
	})
end

return M
