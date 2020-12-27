local vimp = require('vimp')

local M = {}

-- LUA TREE ----------------------------
function M.setup()
    vim.g.nvim_tree_width = 45
    vim.g.nvim_tree_ignore = {'.git', 'node_modules'}
    vim.g.nvim_tree_auto_close = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_hide_dotfiles = 0
    vim.g.nvim_tree_tab_open = 1
    vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}

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
        folder = {
            default = "",
            open = "",
            symlink = "",
        }
    }

    vim.g.nvim_tree_bindings = {
        edit = {'<CR>', 'o', 'l'},
        edit_vsplit = '<C-v>',
        edit_split = '<C-x>',
        edit_tab = '<C-t>',
        toggle_ignored = 'I',
        toggle_dotfiles = 'H',
        refresh = 'R',
        preview = '<Tab>',
        close_node = {'h', '<s-cr>', '<bs>'},
        cd = '<C-]>',
        create = 'a',
        remove = 'd',
        rename = 'r',
        cut = 'x',
        copy = 'c',
        paste = 'p',
        prev_git_item = '[c',
        next_git_item = ']c'
    }

    vimp.nnoremap({'silent'}, '<Leader><Tab>',
                  function() vim.cmd('NvimTreeToggle') end)

    vimp.nnoremap({'silent'}, '<Leader>ltr',
                  function() vim.cmd('NvimTreeRefresh') end)

    vim.api.nvim_exec([[
  augroup NvimTreeOverride
    au!
    au FileType NvimTree setlocal nowrap
  augroup END
  ]], '')
end

return M
