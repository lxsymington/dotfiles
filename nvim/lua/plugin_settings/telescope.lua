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

local M = {}

-- function M.fd()
--     require('telescope.builtin').fd()
-- end

function M.builtin()
    require('telescope.builtin').builtin()
    vimp.nnoremap('<Leader>fd', require('telescope.builtin').fd())
end

-- function M.git_files()
--     require('telescope.builtin').git_files()
-- end

-- function M.live_grep()
--     require('telescope.builtin').live_grep()
-- end

-- function M.oldfiles()
--     require('telescope.builtin').oldfiles()
-- end

function M.project_search()
    require('telescope.builtin').find_files {
        previewer = false,
        layout_strategy = "vertical",
        cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
    }
end

-- function M.buffers()
--     require('telescope.builtin').buffers {
--         shorten_path = false,
--     }
-- end

-- function M.curbuf()
--     local opts = themes.get_dropdown {
--         winblend = 10,
--         border = true,
--         previewer = false,
--         shorten_path = false,
--     }

--     require('telescope.builtin').current_buffer_fuzzy_find(opts)
-- end

-- function M.help_tags()
--     require('telescope.builtin').help_tags {
--         show_version = true,
--     }
-- end

return setmetatable({}, {
    __index = function(_, k)
        reloader()

        if M[k] then
            return M[k]
        else
            return require('telescope.builtin')[k]
        end
    end
})
