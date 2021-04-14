local colours = require('lush_theme.crepuscular-colours')
local feline = require('feline')
local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local M = {}

--[[ local Highlight = {
    __tostring = function(highlight)
        local s = {}
        for k,v in pairs(highlight) do
            table.insert(s, k .. '=' .. v)
        end
        return table.concat(s, ' ')
    end
} ]]

--[[ local create_highlight_group = function(name, highlight)
    setmetatable(highlight, Highlight)

    vim.api.nvim_command(string.format('hi %s %s', name, highlight))
end ]]

--[[ local file_namer = function()
    local file = vim.fn.expand('%:p:~:.')

    if vim.fn.empty(file) == 1 then return '' end
    return #file < 40 and file or vim.fn.pathshorten(file)
end ]]

local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
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
        provider = 'vi_mode',
        hl = function()
            local val = {}

            val.name = vi_mode_utils.get_mode_highlight_name()
            val.fg = colours.black.hex
            val.bg = vi_mode_utils.get_mode_color()
            val.style = 'bold'

            return val
        end,
        left_sep = {'left_rounded_thin', 'left_rounded'},
        right_sep = {'right_rounded', 'right_rounded_thin', ' '}
    }

    components.left.active[2] = {
        provider = 'file_info',
        enabled = buffer_not_empty,
        hl = {
            fg = colours.white.hex,
            bg = colours.lightBlack.hex,
            style = 'bold'
        },
        left_sep = {'left_rounded'},
        right_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = colours.lightBlack.hex
            }
        }
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
                    fg = colours.lightBlue.hex,
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
        left_sep = ' ',
        right_sep = {'right_rounded'}
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

    local vi_mode_colors = {
        NORMAL = colours.lightYellow.hex,
        OP = colours.yellow.hex,
        INSERT = colours.lightGreen.hex,
        VISUAL = colours.lightCyan.hex,
        BLOCK = colours.cyan.hex,
        REPLACE = colours.lightRed.hex,
        ['V-REPLACE'] = colours.lightRed.hex,
        ENTER = colours.purple.hex,
        MORE = colours.blue.hex,
        SELECT = colours.orange.hex,
        COMMAND = colours.lightOrange.hex,
        SHELL = colours.lightBlue.hex,
        TERM = colours.lightPurple.hex,
        NONE = colours.green.hex
    }

    require('feline').setup({
        default_bg = colours.black.hex,
        default_fg = colours.white.hex,
        components = components,
        properties = properties,
        vi_mode_colors = vi_mode_colors
    })
end

return M
