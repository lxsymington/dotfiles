local M = {}

-- UI ----------------------------------
function M.setup()
    -- Keeps X lines visible when scrolling
    vim.o.scrolloff = 5

    -- Enabel auto indent
    vim.bo.autoindent = true

    -- Copy the previous indentation on autoindenting
    vim.bo.copyindent = true

    -- Syntax aware indent correction
    vim.bo.cindent = true
    vim.bo.smartindent = true

    -- Highlight matching parens
    vim.o.showmatch = true

    -- Show command in bottom bar
    vim.o.showcmd = true

    -- Enables the highlighting of search results
    vim.o.hlsearch = true

    -- Show search matches as you type
    vim.o.incsearch = true

    -- Preview effects of :s as you type
    vim.o.inccommand = 'nosplit'

    -- Visual autocomplete of command menu
    vim.o.wildmenu = true

    -- Wildmode settings
    vim.o.wildmode = [[list:lastused,list:longest,full]]

    -- Highlights the current line
    vim.wo.cursorline = true

    -- Redraws only when needed
    vim.o.lazyredraw = true

    -- Keep 50 lines of command line history
    vim.o.history = 50

    -- Always show the sign column
    vim.wo.signcolumn = [[yes:2]]

    -- Make splits remain equal
    vim.o.equalalways = true
    vim.o.eadirection = 'both'

    -- Display the foldcolumn
    vim.wo.foldcolumn = '1'

    -- Enable pseudo-transparency for popup menus
    vim.o.pumblend = 10

    -- Enable pseudo-transparency for floating windows
    vim.wo.winblend = 10

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = [[menuone,longest,noinsert,noselect]]
end

return M
