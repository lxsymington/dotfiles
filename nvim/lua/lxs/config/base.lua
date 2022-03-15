local opt = vim.opt
local g = vim.g
local fn = vim.fn
local M = {}

-- GENERAL
function M.setup()
	-- Sets encoding to UTF-8
	opt.fileencoding = "utf-8"

	-- Do not add BOM marks
	opt.bomb = false

	-- Use host system format
	opt.fileformats = { "unix", "dos", "mac" }

	-- Enables syntax highlighting
	opt.syntax = "enable"

	-- Sets the backspace behaviour to conventional
	opt.backspace = { "indent", "eol", "start" }

	-- Change the default leader ('\') character for custom mappings
	g.mapleader = ","

	-- When a new horizontal split is opened it is opened below
	opt.splitbelow = true

	-- When a new vertical split is opened it is opened to the right
	opt.splitright = true

	-- Enables line numbers
	opt.number = true
	opt.relativenumber = true

	-- Force the cursor onto a new line after 120 characters
	opt.textwidth = 100

	-- Creates a visual boundary
	opt.colorcolumn = { "81", "+1" }

	-- Displays invisibles
	opt.list = true

	-- Sets characters to display for invisible characters
	opt.listchars = {
		space = "⎯",
		tab = "» ",
		eol = "␤",
		nbsp = "⎽",
		extends = "↩",
		precedes = "↪",
	}

	-- Sets ambiguous width characters to be double width
	opt.ambiwidth = "single"

	-- Hide the default mode text (e.g. -- INSERT -- below the statusline)
	opt.showmode = false

	-- Enable the mouse
	opt.mouse = "a"

	-- Set the chord timeout length to 100ms
	opt.timeoutlen = 1000
	opt.ttimeoutlen = 100

	-- Set wrapped lines to continue visual indentation
	opt.breakindent = true

	-- Set breakindent options
	opt.breakindentopt = {
		min = "20",
		shift = "0",
		"sbr",
	}

	-- Hide abandoned buffers instead of unloading them
	opt.hidden = true

	-- Enable auto-saving
	opt.autowriteall = true

	-- Enable auto-reading
	opt.autoread = true

	-- Do not keep a backup file, use versions instead
	opt.backup = false
	opt.writebackup = false

	-- Extra line for display command messages
	opt.cmdheight = 1

	-- Set a shorter time before the CursorHold event is triggered
	opt.updatetime = 300

	-- Don't show |ins-completion-menu| messages
	opt.shortmess:append("c")

	-- Improve mergetool and diff experience by using git's built in diff
	opt.diffopt = { "filler", "iblank", "iwhite", "indent-heuristic", algorithm = "patience" }

	-- Keep an undo file (undo changes after closing)
	if fn.has("persistent_undo") then
		opt.undofile = true
	end

	-- Visual spaces per tab
	opt.tabstop = 4

	-- Size of a <TAB> character
	opt.shiftwidth = 4

	-- Number of spaces per tab
	opt.softtabstop = 4

	-- Use multiples of shiftwidth when indenting with '<' and '>'
	opt.shiftround = true

	-- Insert spaces when pressing tab
	opt.expandtab = true

	-- Insert tabs on the start of a line according to shiftwidth not tabstop
	opt.smarttab = true
end

return M
