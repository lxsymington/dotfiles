local o = vim.o
local bo = vim.bo
local wo = vim.wo
local M = {}

-- UI ----------------------------------
function M.setup()
    -- Keeps X lines visible when scrolling
    o.scrolloff = 5

    -- Enabel auto indent
    o.autoindent = true
    bo.autoindent = true

    -- Copy the previous indentation on autoindenting
    o.copyindent = true
    bo.copyindent = true

    -- Syntax aware indent correction
    o.cindent = true
    bo.cindent = true
    o.smartindent = true
    bo.smartindent = true

    -- Highlight matching parens
    o.showmatch = true

    -- Show command in bottom bar
    o.showcmd = true

    -- Enables the highlighting of search results
    o.hlsearch = true

    -- Show search matches as you type
    o.incsearch = true

    -- Preview effects of :s as you type
    o.inccommand = 'split'

    -- Visual autocomplete of command menu
    o.wildmenu = true

    -- Wildmode settings
    o.wildmode = table.concat({
        'longest:full',
        'full'
    }, ',')

    -- Wild options
    o.wildoptions = 'pum'

    -- Highlights the current line
    wo.cursorline = true

    -- Redraws only when needed
    o.lazyredraw = true

    -- Keep 50 lines of command line history
    o.history = 50

    -- Always show the sign column
    wo.signcolumn = 'yes:2'

    -- Make splits remain equal
    o.equalalways = true
    o.eadirection = 'both'

    -- Display the foldcolumn
    wo.foldcolumn = '1'

    -- Enable pseudo-transparency for popup menus
    o.pumblend = 10

    -- Enable pseudo-transparency for floating windows
    wo.winblend = 10

    -- Set completeopt to have a better completion experience
    o.completeopt = table.concat({
        'menuone',
        'noselect'
    }, ',')
end

return M
