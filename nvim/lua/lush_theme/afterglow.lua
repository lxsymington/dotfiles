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
local red = hsl(350, 60, 40) -- original "#a95062"
local white = hsl(30, 60, 80) -- original "#ebd3b9"
local yellow = hsl(40, 100, 60) -- original "#ffc346"

local lightBlack = hsl(275, 25, 15) -- original "#222035"
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
    Comment      { fg = black.lighten(15), gui="italic" },
    Conceal      { bg = grey, fg = lightGrey },
    Cursor       { gui = "reverse" },
    CursorIM     { gui = "reverse" },
    CursorLine   { bg = black.darken(20) },
    CursorLineNr { bg = black, fg = yellow, gui = "bold" },
    DiffAdd      { fg = lightGreen, gui = "bold" },
    DiffChange   { fg = lightBlue, gui = "bold" },
    DiffDelete   { fg = lightRed, gui = "bold" },
    DiffText     { fg = lightPurple, gui = "undercurl" },
    Directory    { fg = lightBlue, gui = "bold" },
    EndOfBuffer  { fg = lightGrey },
    ErrorMsg     { bg = red, fg = lightWhite },
    FoldColumn   { fg = lightGrey },
    Folded       { gui = "italic" },
    LineNr       { bg = black.lighten(5), fg = black.lighten(40), gui = "bold" },
    MatchParen   { bg = purple, fg = yellow },
    ModeMsg      { fg = lightGrey },
    MoreMsg      { fg = lightPurple, gui = "bold" },
    MsgArea      { fg = lightGreen, gui = "italic" },
    MsgSeparator { fg = yellow },
    NonText      { fg = grey },
    Normal       { bg = black, fg = white },
    NormalFloat  { bg = grey },
    NormalNC     { bg = lightBlack, fg = white },
    Pmenu        { bg = black.darken(20), fg = white },
    PmenuSbar    { bg = black.darken(40) },
    PmenuSel     { bg = purple, fg = yellow, gui = "bold" },
    PmenuThumb   { bg = lightYellow, fg = blue },
    Question     { fg = lightOrange },
    QuickFixLine { bg = purple, fg = yellow },
    SignColumn   { bg = black, gui = "italic"  },
    SpecialKey   { fg = purple },
    SpellRare    { fg = lightBlue, gui = "undercurl" },
    StatusLine   { bg = black.darken(20) },
    StatusLineNC { bg = black },
    Substitute   { bg = lightPurple, fg = lightYellow },
    TabLine      { bg = blue, fg = lightWhite },
    TabLineFill  { bg = grey, fg = black },
    TabLineSel   { Normal },
    TermCursor   { Cursor },
    TermCursorNC { bg = white, fg = black },
    Title        { fg = orange },
    VertSplit    { fg = yellow },
    Visual       { bg = blue },
    VisualNOS    { bg = lightCyan },
    WarningMsg   { bg = lightYellow, fg = red },
    Whitespace   { fg = black.lighten(15) },
    WildMenu     { bg = green, gui = "bold" },
    lCursor      { gui = "reverse, bold" },

    Constant       { fg = lightCyan, gui = "bold" }, -- (preferred) any constant
    String         { fg = lightWhite, gui = "italic" }, --   a string constant: "this is a string"
    Character      { fg = lightGreen }, --  a character constant: 'c', '\n'
    Number         { fg = lightRed }, --   a number constant: 234, 0xff
    Boolean        { fg = yellow }, --  a boolean constant: TRUE, false
    Float          { Number }, --    a floating point constant: 2.3e10

    Identifier     { fg = lightYellow }, -- (preferred) any variable name
    Function       { fg = cyan, gui = "bold" }, -- function name (also: methods for classes)

    Statement      { fg = green }, -- (preferred) any statement
    Conditional    { fg = orange }, --  if, then, else, endif, switch, etc.
    Repeat         { fg = lightPurple }, --   for, do, while, etc.
    Label          { fg = red }, --    case, default, etc.
    Operator       { fg = lightOrange }, -- "sizeof", "+", "*", etc.
    Keyword        { fg = blue }, --  any other keyword
    Exception      { fg = red, gui = "bold, undercurl"}, --  try, catch, throw

    PreProc        { fg = lightOrange }, -- (preferred) generic Preprocessor
    Include        { fg = blue }, --  preprocessor #include
    Define         { }, --   preprocessor #define
    -- Macro          { }, --    same as Define
    -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.

    -- Type           { }, -- (preferred) int, long, char, etc.
    -- StorageClass   { }, -- static, register, volatile, etc.
    -- Structure      { }, --  struct, union, enum, etc.
    -- Typedef        { }, --  A typedef

    -- Special        { }, -- (preferred) any special symbol
    -- SpecialChar    { }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    -- Delimiter      { }, --  character that needs attention
    -- SpecialComment { }, -- special things inside a comment
    -- Debug          { }, --    debugging statements

    -- Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
    -- Bold       { gui = "bold" },
    -- Italic     { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    -- Error          { }, -- (preferred) any erroneous construct

    -- Todo           { }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

  }
end)

return theme
