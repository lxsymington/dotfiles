local nvim_tree = require('nvim-tree')
local nnoremap = vim.keymap.nnoremap
local cmd = vim.cmd

local M = {}

-- LUA TREE ----------------------------
function M.setup()
    vim.g.nvim_tree_width = 60
    vim.g.nvim_tree_ignore = {'.git', 'node_modules'}
    vim.g.nvim_tree_auto_close = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_hide_dotfiles = 0
    vim.g.nvim_tree_tab_open = 1
    vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
    vim.g.nvim_tree_disable_netrw = 0
    vim.g.nvim_tree_hijack_netrw = 0

    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            renamed = "➜",
            staged = "✓",
            unmerged = "",
            unstaged = "✗",
            untracked = "★"
        },
        folder = {default = "", open = "", symlink = ""}
    }

    local function bind(action)
        return string.format(":lua require('nvim-tree').on_keypress('%s')<CR>", action)
    end

    vim.g.nvim_tree_bindings = {
        ["l"] = bind('edit'),
        ["h"] = bind("close_node"),
        ["-"] = bind("dir_up")
    }

    nnoremap({'<Leader><Tab>', function() cmd('NvimTreeToggle') end})
end

return M
