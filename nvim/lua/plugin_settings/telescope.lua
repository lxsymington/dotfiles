local vimp = require('vimp')

local should_reload = true
local reloader = function()
    if should_reload then
        -- RELOAD('plenary')
        -- RELOAD('popup')
        -- RELOAD('telescope')
    end
end

reloader()

-- local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')

local M = {}

function M.setup()
    require('telescope').setup {
            defaults = {
                prompt_prefix = '➜',

                winblend = 10,
                preview_cutoff = 120,

                scroll_strategy = 'cycle',
                layout_strategy = "horizontal",
                layout_defaults = {
                    horizontal = {
                        width_padding = 0.1,
                        height_padding = 0.1,
                        preview_width = 0.6,
                    },
                    vertical = {
                        width_padding = 0.05,
                        height_padding = 1,
                        preview_height = 0.5,
                    }
                },

                sorting_strategy = "descending",
                prompt_position = "bottom",
                color_devicons = true,

                -- for the top/right/bottom/left border.  Optionally
                -- followed by the character to use for the
                -- topleft/topright/botright/botleft corner.
                borderchars = {
                    { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
                    preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
                },

                file_sorter = sorters.get_fzy_sorter,
            }
        }

    vimp.nnoremap('<Leader>fd', function()
            builtin.fd()
        end)

    vimp.nnoremap('<Leader>fgf', function()
            builtin.git_files()
        end)

    vimp.nnoremap('<Leader>fpf', function()
            builtin.find_files {
                    previewer = false,
                    layout_strategy = "vertical",
                    cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
                }
        end)

    vimp.nnoremap('<Leader>fht', function()
            builtin.help_tags()
        end)

    vimp.nnoremap('<Leader>fb', function()
            builtin.buffers()
        end)

    vimp.nnoremap('<Leader>lg', function()
            builtin.live_grep()
        end)

    vimp.nnoremap('<Leader>lbg', function()
            local opts = themes.get_dropdown {
                    winblend = 10,
                    border = true,
                    previewer = false,
                    shorten_path = false,
                }

            builtin.current_buffer_fuzzy_find(opts)
        end)
end

function M.fd()
    builtin.fd()
end

function M.builtin()
    builtin.builtin()
end

function M.git_files()
    builtin.git_files()
end

function M.live_grep()
    builtin.live_grep()
end

function M.oldfiles()
    builtin.oldfiles()
end

function M.project_search()
    builtin.find_files {
            previewer = false,
            layout_strategy = "vertical",
            cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
        }
end

function M.buffers()
    builtin.buffers {
        shorten_path = false,
    }
end

function M.curbuf()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
    }

    builtin.current_buffer_fuzzy_find(opts)
end

function M.help_tags()
    builtin.help_tags {
        show_version = true,
    }
end

return setmetatable({}, {
        __index = function(_, k)
            reloader()

            if M[k] then
                return M[k]
            else
                return builtin[k]
            end
        end
    })
