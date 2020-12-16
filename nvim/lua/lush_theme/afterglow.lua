local lush = require('lush')
local hsl = lush.hsl

-- AFTERGLOW ---------------------------

-- Colours
local black = hsl(275, 20, 10) -- original "#111224"
local blue = hsl(215, 75, 30) -- original "#155199"
local cyan = hsl(190, 30, 50) -- original "#6187ae"
local green = hsl(130, 25, 25) -- original "#354e39"
local grey = hsl(315, 5, 30) -- original "#786674"
local orange = hsl(20, 75, 40) -- original "#ec722f"
local purple = hsl(300, 45, 25) -- original "#673a5b"
local red = hsl(350, 40, 40) -- original "#a95062"
local white = hsl(30, 60, 80) -- original "#ebd3b9"
local yellow = hsl(40, 100, 60) -- original "#ffc346"

local lightBlack = hsl(245, 25, 15) -- original "#222035"
local lightBlue = hsl(210, 50, 45) -- original "#356ea5"
local lightCyan = hsl(215, 40, 65) -- original "#83a0c8"
local lightGreen = hsl(85, 30, 35) -- original "#5e723f"
local lightGrey = hsl(310, 10, 60) -- original "#9f8d9d"
local lightOrange = hsl(25, 100, 60) -- original "#fe882e"
local lightPurple = hsl(300, 30, 40) -- original "#9f7195"
local lightRed = hsl(0, 45, 60) -- original "#c5696e"
local lightWhite = hsl(45, 70, 95) -- original "#fcf9f0"
local lightYellow = hsl(40, 100, 75) -- original "#ffd782"

-- BG        cterm=reverse gui=reverse
-- Bold      cterm=bold gui=bold
-- Italic    cterm=italic gui=italic

-- Theme
local theme = lush(function()
  return {
    ColorColumn  { bg = black.darken(20) },
    -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor       { gui = "reverse" },
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorLine { bg = black.darken(20) },
    CursorLineNr { bg = black, fg = yellow, gui = "bold" },
    -- DiffAdd      { }, -- diff mode: Added line |diff.txt|
    -- DiffChange   { }, -- diff mode: Changed line |diff.txt|
    -- DiffDelete   { }, -- diff mode: Deleted line |diff.txt|
    -- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
    Directory    { fg = lightBlue, gui = "bold" }, -- directory names (and other special names in listings)
    -- EndOfBuffer  { }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- ErrorMsg     { }, -- error messages on the command line
    -- FoldColumn   { }, -- 'foldcolumn'
    -- Folded       { }, -- line used for closed folds
    LineNr       { bg = black.lighten(5), fg = black.lighten(40), gui = "bold" },
    -- MatchParen   { }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MoreMsg      { }, -- |more-prompt|
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    NonText      { fg = grey },
    Normal { fg = white, bg = black },
    -- NormalFloat  { }, -- Normal text in floating windows.
    -- NormalNC     { }, -- normal text in non-current windows
    -- Pmenu        { }, -- Popup menu: normal item.
    -- PmenuSbar    { }, -- Popup menu: scrollbar.
    -- PmenuSel     { }, -- Popup menu: selected item.
    -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
    -- Question     { }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SignColumn   { bg = black, gui = "italic"  },
    SpecialKey   { fg = purple },
    SpellRare    { fg = lightBlue, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine   { bg = black.darken(20) },
    StatusLineNC { bg = black },
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    -- TabLine      { }, -- tab pages line, not active tab page label
    -- TabLineFill  { }, -- tab pages line, where there are no labels
    -- TabLineSel   { }, -- tab pages line, active tab page label
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    -- Title        { }, -- titles for output from ":set all", ":autocmd" etc.
    VertSplit    { fg = yellow }, -- the column separating vertically split windows
    Visual { bg = blue },
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg   { }, -- warning messages
    Whitespace   { fg = black.lighten(15) },
    -- WildMenu     { }, -- current match in 'wildmenu' completion
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  }
end)

return theme
