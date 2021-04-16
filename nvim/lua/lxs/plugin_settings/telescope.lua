local nnoremap = vim.keymap.nnoremap

local should_reload = true
local reloader = function()
    if should_reload then
        RELOAD('plenary')
        RELOAD('popup')
        RELOAD('telescope')
    end
end

reloader()

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

local M = {}

-- TELESCOPE ---------------------------
function M.setup()
    require('telescope').setup {
        defaults = {
            -- for the top/right/bottom/left border.  Optionally
            -- followed by the character to use for the
            -- topleft/topright/botright/botleft corner.
            layout_strategy = "flex",
            layout_defaults = {
                horizontal = {
                    width_padding = 0.1,
                    height_padding = 0.1,
                    preview_width = 0.6
                },
                vertical = {
                    width_padding = 0.05,
                    height_padding = 1,
                    preview_height = 0.5
                }
            },
            prompt_prefix = '🔭 ➜',
            scroll_strategy = 'cycle',
            winblend = 10,
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new
        },
        extensions = {
            frecency = {
                show_scores = false,
                show_unindexed = true,
                ignore_patterns = {"*.git/*", "*/node_modules/*", "*/tmp/*"},
                workspaces = {
                    ["conf"] = os.getenv('HOME') .. "/.config",
                    ["data"] = os.getenv('HOME') .. "/.local/share",
                    ["development"] = os.getenv('HOME') .. "/Development",
                }
            },
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        },
    }

    require('telescope').load_extension("frecency")
    require('telescope').load_extension('fzy_native')

    nnoremap({'<Leader>fd', builtin.fd})

    nnoremap({'<Leader>ff', function()
        local opts = themes.get_dropdown {
            winblend = 10,
            border = true,
            shorten_path = false
        }

        require('telescope').extensions.frecency.frecency(opts)
    end})

    nnoremap({'<Leader>fgf', builtin.git_files})

    nnoremap({'<Leader>fpf', function()
        builtin.find_files {
            previewer = false,
            layout_strategy = "vertical",
            cwd = require('lsp_config.util').root_pattern(".git")(
                vim.fn.expand("%:p"))
        }
    end})

    nnoremap({'<Leader>fht', builtin.help_tags})

    nnoremap({'<Leader>fb', builtin.buffers})

    nnoremap({'<Leader>lg', builtin.live_grep})

    nnoremap({'<Leader>lbg', function()
        local opts = themes.get_dropdown {
            winblend = 10,
            border = true,
            previewer = false,
            shorten_path = false
        }

        builtin.current_buffer_fuzzy_find(opts)
    end})

    nnoremap({'<Leader>sr', builtin.lsp_references})

    nnoremap({'<Leader><space>', builtin.lsp_code_actions})

    nnoremap({'<Leader>?', builtin.lsp_range_code_actions})

    nnoremap({'<Leader>gb', builtin.git_branches})

    nnoremap({'<Leader>gs', builtin.git_status})
end

function M.fd() builtin.fd() end

function M.builtin() builtin.builtin() end

function M.git_files() builtin.git_files() end

function M.live_grep() builtin.live_grep() end

function M.oldfiles() builtin.oldfiles() end

function M.project_search()
    builtin.find_files {
        previewer = false,
        layout_strategy = "vertical",
        cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p"))
    }
end

function M.buffers() builtin.buffers {shorten_path = false} end

function M.curbuf()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false
    }

    builtin.current_buffer_fuzzy_find(opts)
end

function M.help_tags() builtin.help_tags {show_version = true} end

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
