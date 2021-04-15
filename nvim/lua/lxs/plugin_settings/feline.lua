local colours = require('lush_theme.crepuscular-colours')
local feline = require('feline')
local lsp = require('feline.providers.lsp')
local devicons = require('nvim-web-devicons')
local fn = vim.fn
local bo = vim.bo
local b = vim.b
local M = {}

local vi_mode_colors = {
    NORMAL = colours.yellow.hex,
    OP = colours.lightYellow.hex,
    INSERT = colours.green.hex,
    VISUAL = colours.cyan.hex,
    BLOCK = colours.lightCyan.hex,
    REPLACE = colours.red.hex,
    ['V-REPLACE'] = colours.lightRed.hex,
    ENTER = colours.lightPurple.hex,
    MORE = colours.lightBlue.hex,
    SELECT = colours.lightOrange.hex,
    COMMAND = colours.orange.hex,
    SHELL = colours.blue.hex,
    TERM = colours.purple.hex,
    NONE = colours.lightGreen.hex
}

local mode_alias_map = {
    [''] = { name = 'Select-Block', fg = colours.black.hex, bg = colours.lightPurple.hex },
    [''] = { name = 'Visual-Block', fg = colours.black.hex, bg = colours.lightCyan.hex },
    ['!'] = { name = 'Shell', fg = colours.black.hex, bg = colours.lightBlue.hex },
    ['no'] = { name = 'Operator-Pending', fg = colours.black.hex, bg = colours.lightGrey.hex },
    ['r?'] = { name = 'Confirm', fg = colours.black.hex, bg = colours.grey.hex },
    c = { name = 'Command-Line', fg = colours.black.hex, bg = colours.orange.hex },
    ce = { name = 'Normal-Ex', fg = colours.black.hex, bg = colours.lightOrange.hex },
    cv = { name = 'Vim-Ex', fg = colours.black.hex, bg = colours.lightOrange.hex },
    i = { name = 'Insert', fg = colours.black.hex, bg = colours.green.hex },
    ic = { name = 'Insert-Completion', fg = colours.black.hex, bg = colours.lightGreen.hex },
    ix = { name = 'Insert-Completion', fg = colours.black.hex, bg = colours.lightGreen.hex },
    n = { name = 'Normal', fg = colours.black.hex, bg = colours.yellow.hex },
    niI = { name = 'Normal-Insert', fg = colours.black.hex, bg = colours.lightYellow.hex },
    niR = { name = 'Normal-Replace', fg = colours.black.hex, bg = colours.lightYellow.hex },
    niV = { name = 'Normal-Virtual-Replace', fg = colours.black.hex, bg = colours.lightYellow.hex },
    no = { name = 'Operator-Pending', fg = colours.black.hex, bg = colours.lightGrey.hex },
    noV = { name = 'Operator-Pending', fg = colours.black.hex, bg = colours.lightGrey.hex },
    nov = { name = 'Operator-Pending', fg = colours.black.hex, bg = colours.lightGrey.hex },
    r = { name = 'Hit-Enter', fg = colours.black.hex, bg = colours.grey.hex },
    R = { name = 'Replace', fg = colours.black.hex, bg = colours.red.hex },
    Rc = { name = 'Replace-Completion', fg = colours.black.hex, bg = colours.lightRed.hex },
    rm = { name = '-- More --', fg = colours.black.hex, bg = colours.grey.hex },
    Rv = { name = 'Virtual-Replace', fg = colours.black.hex, bg = colours.lightRed.hex },
    Rx = { name = 'Replace-Completion', fg = colours.black.hex, bg = colours.lightRed.hex },
    s = { name = 'Select', fg = colours.black.hex, bg = colours.purple.hex },
    S = { name = 'Select-Line', fg = colours.black.hex, bg = colours.lightPurple.hex },
    t = { name = 'Terminal', fg = colours.black.hex, bg = colours.blue.hex },
    v = { name = 'Visual', fg = colours.black.hex, bg = colours.cyan.hex },
    V = { name = 'Visual-Line', fg = colours.black.hex, bg = colours.lightCyan.hex },
}

local vi_mode = function()
    local mode = fn.mode()
    local mode_alias = string.upper(mode_alias_map[mode].name)

    return string.format('  %s ', mode_alias)
end

local file_namer = function()
    local file_path = fn.expand('%:p')

    if fn.empty(file_path) == 1 then return '' end

    local file_icon = devicons.get_icon(
        fn.fnamemodify(file_path, ':t'),
        fn.fnamemodify(file_path, ':e'),
        { default = true }
    )
    local relative_file_path = fn.fnamemodify(file_path, ':~:.')
    local short_file_path = #relative_file_path < 40 
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

    vertical_bar	'┃'
    vertical_bar_thin	'│'
    left	''
    right	''
    left_filled	''
    right_filled	''
    slant_left	''
    slant_left_thin	''
    slant_right	''
    slant_right_thin	''
    slant_left_2	''
    slant_left_2_thin	''
    slant_right_2	''
    slant_right_2_thin	''
    left_rounded	''
    left_rounded_thin	''
    right_rounded	''
    right_rounded_thin	''
    circle	'●'

]]

-- FELINE ------------------------------
function M.setup()
    local properties = {
        force_inactive = {
            filetypes = {},
            buftypes = {},
            bufnames = {}
        }
    }

    local components = {
        left = {
            active = {},
            inactive = {}
        },
        right = {
            active = {},
            inactive = {}
        }
    }

    properties.force_inactive.filetypes = {
        'NvimTree',
        'dbui',
        'packer',
        'startify',
        'fugitive',
        'fugitiveblame'
    }

    properties.force_inactive.buftypes = {
        'terminal'
    }

    components.left.active[1] = {
        provider = vi_mode,
        hl = function()
            local val = {}
            local mode = fn.mode();

            val.name = string.gsub(mode_alias_map[mode].name, '%A', '')
            val.fg = mode_alias_map[mode].fg
            val.bg = mode_alias_map[mode].bg
            val.style = 'bold'

            return val
        end,
        left_sep = {'left_rounded_thin', 'left_rounded'},
        right_sep = {'right_rounded', 'right_rounded_thin', ' '}
    }

    components.left.active[2] = {
        provider = file_namer,
        enabled = buffer_not_empty,
        hl = {
            fg = colours.white.hex,
            bg = colours.lightBlack.hex,
            style = 'bold'
        },
        left_sep = {'left_rounded'},
    }

    components.left.active[3] = {
        provider = 'file_size',
        enabled = buffer_not_empty,
        hl = {
            fg = colours.lightGrey.hex,
            bg = colours.lightBlack.hex,
            style = 'italic'
        },
        left_sep = {
            {
                str = 'vertical_bar',
                hl = {
                    fg = colours.orange.hex,
                    bg = colours.lightBlack.hex
                }
            },
            {
                str = ' ',
                hl = {
                    fg = 'NONE',
                    bg = colours.lightBlack.hex
                }
            }
        },
        right_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = colours.lightBlack.hex
            }
        }
    }

    components.left.active[4] = {
        provider = 'git_branch',
        hl = {
            fg = colours.lightWhite.hex,
            bg = colours.blue.hex,
            style = 'bold'
        },
        right_sep = function()
            return {
                str = '',
                hl = {
                    fg = b.gitsigns_status_dict and colours.blue.hex or colours.lightBlack.hex,
                    bg = 'bg'
                }
            }
        end
    }

    components.left.active[5] = {
        provider = 'git_diff_added',
        hl = {
            fg = colours.green.hex,
            bg = 'bg'
        }
    }

    components.left.active[6] = {
        provider = 'git_diff_changed',
        hl = {
            fg = colours.orange.hex,
            bg = 'bg'
        }
    }

    components.left.active[7] = {
        provider = 'git_diff_removed',
        hl = {
            fg = colours.red.hex,
            bg = 'bg'
        },
    }

    components.right.active[1] = {
        provider = 'diagnostic_errors',
        enabled = function() return lsp.diagnostics_exist('Error') end,
        hl = { fg = colours.red.hex }
    }

    components.right.active[2] = {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist('Warning') end,
        hl = { fg = colours.yellow.hex }
    }

    components.right.active[3] = {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist('Hint') end,
        hl = { fg = colours.cyan.hex }
    }

    components.right.active[4] = {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist('Information') end,
        hl = { fg = colours.lightBlue.hex }
    }

    components.right.active[5] = {
        provider = 'position',
        left_sep = {
            str = '  ',
            hl = {
                fg = colours.lightGrey.hex,
                bg = 'bg'
            }
        },
        right_sep = {
            str = '  ',
            hl = {
                fg = colours.lightGrey.hex,
                bg = 'bg'
            }
        },
        hl = { fg = colours.lightGrey.hex }
    }

    components.right.active[6] = {
        provider = 'line_percentage',
        hl = {
            style = 'bold'
        },
        left_sep = ' ',
        right_sep = ' '
    }

    components.right.active[7] = {
        provider = 'scroll_bar',
        hl = {
            fg = colours.lightPurple.hex,
            style = 'bold'
        }
    }

    components.left.inactive[1] = {
        provider = 'file_type',
        hl = {
            fg = colours.white.hex,
            bg = colours.blue.hex,
            style = 'bold'
        },
        left_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = colours.blue.hex
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = {
                    fg = 'NONE',
                    bg = colours.blue.hex
                }
            },
            'right_rounded'
        }
    }

    require('feline').setup({
        default_bg = colours.black.hex,
        default_fg = colours.white.hex,
        components = components,
        properties = properties,
    })
end

return M
