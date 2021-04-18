local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local fn = vim.fn
local M = {}

-- GENERAL
function M.setup()
	-- Sets encoding to UTF-8
	o.fileencoding = "utf-8"
	bo.fileencoding = "utf-8"

	-- Do not add BOM marks
	o.bomb = false
	bo.bomb = false

	-- Use host system format
	o.fileformats = table.concat({
		"unix",
		"dos",
		"mac",
	}, ",")

	-- Enables syntax highlighting
	g.syntax = "enable"

	-- Security
	o.modelines = 0

	-- Sets the backspace behaviour to conventional
	o.backspace = table.concat({
		"indent",
		"eol",
		"start",
	}, ",")

	-- Change the default leader ('\') character for custom mappings
	g.mapleader = ","

	-- When a new horizontal split is opened it is opened below
	o.splitbelow = true

	-- When a new vertical split is opened it is opened to the right
	o.splitright = true

	-- Enables line numbers
	wo.number = true
	wo.relativenumber = true

	-- Force the cursor onto a new line after 120 characters
	o.textwidth = 120
	bo.textwidth = 120

	-- Creates a visual boundary
	wo.colorcolumn = table.concat({
		"81",
		"+1",
	}, ",")

	-- Displays invisibles
	wo.list = true

	-- Sets characters to display for invisible characters
	o.listchars = table.concat({
		"space:⎯",
		"tab:» ",
		"eol:␤",
		"nbsp:⎽",
		"extends:↩",
		"precedes:↪",
	}, ",")

	-- Sets ambiguous width characters to be double width
	o.ambiwidth = "single"

	-- Hide the default mode text (e.g. -- INSERT -- below the statusline)
	o.showmode = false

	-- Enable the mouse
	o.mouse = "a"

	-- Set the chord timeout length to 100ms
	o.timeoutlen = 1000
	o.ttimeoutlen = 100

	-- Set wrapped lines to continue visual indentation
	wo.breakindent = true

	-- Set breakindent options
	wo.breakindentopt = table.concat({
		"min:20",
		"shift:0",
		"sbr",
	}, ",")

	-- Hide abandoned buffers instead of unloading them
	o.hidden = true

	-- Enable auto-saving
	o.autowriteall = true

	-- Enable auto-reading
	o.autoread = true

	-- Do not keep a backup file, use versions instead
	o.backup = false
	o.writebackup = false

	-- Extra line for display command messages
	o.cmdheight = 1

	-- Set a shorter time before the CursorHold event is triggered
	o.updatetime = 300

	-- Don't show |ins-completion-menu| messages
	o.shortmess = o.shortmess .. "c"

	-- Improve mergetool and diff experience by using git's built in diff
	o.diffopt = table.concat({
		"filler",
		"iblank",
		"iwhite",
		"indent-heuristic",
		"algorithm:patience",
	}, ",")

	-- Keep an undo file (undo changes after closing)
	if fn.has("persistent_undo") then
		o.undofile = true
	end

	-- Visual spaces per tab
	o.tabstop = 4
	bo.tabstop = 4

	-- Size of a <TAB> character
	o.shiftwidth = 4
	bo.shiftwidth = 4

	-- Number of spaces per tab
	o.softtabstop = 4
	bo.softtabstop = 4

	-- Use multiples of shiftwidth when indenting with '<' and '>'
	o.shiftround = true

	-- Insert spaces when pressing tab
	o.expandtab = true
	bo.expandtab = true

	-- Insert tabs on the start of a line according to shiftwidth not tabstop
	o.smarttab = true
end

return M
