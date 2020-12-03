local vimp = require('vimp')

local M = {}

-- LUA TREE ----------------------------
function M.setup()
  vim.g.lua_tree_width = 45
  vim.g.lua_tree_ignore = { '.git', 'node_modules' }
  vim.g.lua_tree_auto_close = 1
  vim.g.lua_tree_follow = 1
  vim.g.lua_tree_indent_markers = 1
  vim.g.lua_tree_hide_dotfiles = 0
  vim.g.lua_tree_tab_open = 1
  vim.g.lua_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
  }

  vim.g.lua_tree_icons = {
    default = '',
    git= {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★"
    },
    folder = {
      default = "",
      open = ""
    }
  }

  vim.g.lua_tree_bindings = {
    edit =            {'<CR>', 'o', 'l'},
    edit_vsplit =     '<C-v>',
    edit_split =      '<C-x>',
    edit_tab =        '<C-t>',
    toggle_ignored =  'I',
    toggle_dotfiles = 'H',
    refresh =         'R',
    preview =         '<Tab>',
    cd =              '<C-]>',
    create =          'a',
    remove =          'd',
    rename =          'r',
    cut =             'x',
    copy =            'c',
    paste =           'p',
    prev_git_item =   '[c',
    next_git_item =   ']c',
  }

  vimp.nnoremap({'silent'}, '<Leader><Tab>', function()
    vim.cmd('LuaTreeToggle')
  end)

  vimp.nnoremap({'silent'}, '<Leader>ltr', function()
    vim.cmd('LuaTreeRefresh')
  end)

  vim.api.nvim_exec([[
  augroup LuaTreeOverride
    au!
    au FileType LuaTree setlocal nowrap
  augroup END
  ]], '')
end

return M
