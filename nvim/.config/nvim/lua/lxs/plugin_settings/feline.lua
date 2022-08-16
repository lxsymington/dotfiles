local feline = require('feline')
local lsp = require('feline.providers.lsp')
local devicons = require('nvim-web-devicons')
local Theme = require('lxs.utils').Theme
local colours = require(vim.g.colors_name .. '.colours')
local fn = vim.fn
local api = vim.api
local bo = vim.bo
local b = vim.b
local M = {}

local theme = Theme.new(colours)

local mode_alias_map = {
	[''] = {
		name = 'Select-Block',
		fg = theme.foreground,
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

local file_name_component = {
	provider = file_namer,
	enabled = buffer_not_empty,
	hl = {
		fg = theme.foreground_alt,
		bg = theme.background_alt,
		style = 'bold',
	},
	left_sep = { 'block' },
}

local file_size_component = {
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
}

local git_branch_component = {
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
				bg = theme.background,
			},
		}
	end,
}

local git_additions_component = {
	provider = 'git_diff_added',
	hl = { fg = theme.green, bg = theme.background },
}

local git_changes_component = {
	provider = 'git_diff_changed',
	hl = { fg = theme.orange, bg = theme.background },
}

local git_deletions_component = {
	provider = 'git_diff_removed',
	hl = { fg = theme.red, bg = theme.background },
}

local buf_number_component = {
	provider = '%n',
	hl = { fg = theme.white_alt, bg = theme.magenta, style = 'bold' },
	left_sep = {
		{ str = 'left_rounded_thin', hl = { fg = theme.magenta, bg = theme.background } },
		{ str = 'left_rounded', hl = { fg = theme.magenta, bg = theme.background } },
	},
	right_sep = { 'block' },
}

local vi_mode_component = {
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
	right_sep = {
		{
			str = 'right_rounded',
			hl = function()
				local mode = fn.mode()

				return {
					name = string.gsub(
						mode_alias_map[mode].name,
						'(%a+)',
						'FelineViModeHighlight%1'
					),
					fg = mode_alias_map[mode].bg,
					bg = theme.background,
				}
			end,
		},
		{
			str = 'right_rounded_thin',
			hl = function()
				local mode = fn.mode()

				return {
					name = string.gsub(
						mode_alias_map[mode].name,
						'(%a+)',
						'FelineViModeHighlight%1'
					),
					fg = mode_alias_map[mode].bg,
					bg = theme.background,
				}
			end,
		},
	},
}

local diagnostic_errors_component = {
	provider = 'diagnostic_errors',
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.Error)
	end,
	hl = { fg = theme.red, bg = theme.background },
}

local diagnostic_warnings_component = {
	provider = 'diagnostic_warnings',
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
	end,
	hl = { fg = theme.yellow, bg = theme.background },
}

local diagnostic_hints_component = {
	provider = 'diagnostic_hints',
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
	end,
	hl = { fg = theme.cyan, bg = theme.background },
}

local diagnostic_info_component = {
	provider = 'diagnostic_info',
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
	end,
	hl = { fg = theme.blue_alt, bg = theme.background },
}

local document_position_component = {
	provider = 'position',
	left_sep = {
		{
			str = ' ',
			hl = { fg = 'NONE', bg = theme.background },
		},
		{
			str = 'left_rounded',
			hl = { fg = theme.magenta_alt, bg = theme.background },
		},
		{
			str = 'left_rounded_thin',
			hl = { bg = theme.magenta_alt, fg = theme.background },
		},
		{
			str = 'left_rounded',
			hl = { bg = theme.magenta_alt, fg = theme.background },
		},
		{
			str = '  ',
			hl = { fg = theme.magenta, bg = theme.background },
		},
	},
	right_sep = {
		{
			str = '  ',
			hl = { fg = theme.magenta, bg = theme.background },
		},
		{
			str = 'right_rounded',
			hl = {
				bg = theme.magenta_alt,
				fg = theme.background,
			},
		},
		{
			str = 'right_rounded_thin',
			hl = {
				bg = theme.magenta_alt,
				fg = theme.background,
			},
		},
	},
	hl = { fg = theme.grey_alt, bg = theme.background },
}

local line_percentage_component = {
	provider = 'line_percentage',
	hl = {
		bg = theme.magenta_alt,
		fg = theme.background,
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
}

local scroll_bar_component = {
	provider = 'scroll_bar',
	hl = {
		bg = theme.magenta,
		fg = theme.background,
		style = 'bold',
	},
}

-- FELINE ------------------------------
function M.setup()
	local statusline_components = {
		active = {
			{
				git_branch_component,
				git_additions_component,
				git_changes_component,
				git_deletions_component,
			},
			{
				buf_number_component,
				vi_mode_component,
			},
			{
				diagnostic_errors_component,
				diagnostic_warnings_component,
				diagnostic_hints_component,
				diagnostic_info_component,
				document_position_component,
				line_percentage_component,
				scroll_bar_component,
			},
		},
	}

	feline.setup({
		colors = {
			bg = theme.background,
			fg = theme.foreground,
		},
		components = statusline_components,
	})

	local winbar_centre = {
		vim.tbl_extend('keep', {
			left_sep = {
				str = 'slant_left',
				hl = { fg = theme.background_alt, bg = theme.background },
			},
		}, file_name_component),
		vim.tbl_extend('keep', {
			right_sep = {
				str = 'slant_right',
				hl = { fg = theme.background_alt, bg = theme.background },
			},
		}, file_size_component),
	}

	feline.winbar.setup({
		components = {
			active = {
				{},
				winbar_centre,
				{},
			},
			inactive = {
				{},
				winbar_centre,
				{},
			},
		},
	})
end

return M
