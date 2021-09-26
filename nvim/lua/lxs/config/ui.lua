local opt = vim.opt
local M = {}

-- UI ----------------------------------
function M.setup()
	-- Keeps X lines visible when scrolling
	opt.scrolloff = 5

	-- Enabel auto indent
	opt.autoindent = true

	-- Copy the previous indentation on autoindenting
	opt.copyindent = true

	-- Syntax aware indent correction
	opt.cindent = true
	opt.smartindent = true

	-- Highlight matching parens
	opt.showmatch = true

	-- Show command in bottom bar
	opt.showcmd = true

	-- Enables the highlighting of search results
	opt.hlsearch = true

	-- Show search matches as you type
	opt.incsearch = true

	-- Preview effects of :s as you type
	opt.inccommand = 'split'

	-- Visual autocomplete of command menu
	opt.wildmenu = true

	-- Wildmode settings
	opt.wildmode = { longest = 'full', 'full' }

	-- Wild options
	opt.wildoptions = 'pum'

	-- Highlights the current line
	opt.cursorline = true

	-- Redraws only when needed
	opt.lazyredraw = true

	-- Keep 50 lines of command line history
	opt.history = 50

	-- Always show the sign column
	opt.signcolumn = 'yes:2'

	-- Make splits remain equal
	opt.equalalways = true
	opt.eadirection = 'both'

	-- Display the foldcolumn
	opt.foldcolumn = '1'

	-- Enable pseudo-transparency for popup menus
	opt.pumblend = 10

	-- Enable pseudo-transparency for floating windows
	opt.winblend = 10

	-- Set completeopt to have a better completion experience
	opt.completeopt = { 'menuone', 'noselect' }

	-- Set characters to fill the statuslines and vertical separators.
	opt.fillchars = {
		stl = ' ', -- ' ' or '^' statusline of the current window
		stlnc = ' ', -- ' ' or '=' statusline of the non-current windows
		vert = '│', -- '│' or '|' vertical separators |:vsplit|
		fold = '╍', -- '·' or '-' filling 'foldtext'
		foldopen = '╌', -- '-' mark the beginning of a fold
		foldclose = '━', -- '+' show a closed fold
		foldsep = '│', -- '│' or '|' open fold middle marker
		diff = '╱', -- '-' deleted lines of the 'diff' option
		msgsep = '━', -- ' ' message separator 'display'
		eob = '∅', -- '~' empty lines at the end of a buffer
	}
end

return M
