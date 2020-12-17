local lush = require('lush')
local hsl = lush.hsl

-- CREPUSCULAR -------------------------

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
local lightCyan = hsl(190, 60, 75) -- original "#83a0c8"
local lightGreen = hsl(85, 30, 45) -- original "#5e723f"
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
return lush(function()
  return {
    ColorColumn  { bg = black.darken(20), gui = "nocombine" },
    Comment      { fg = black.lighten(15), gui = "nocombine,italic" },
    Conceal      { bg = grey, fg = lightGrey, gui = "nocombine" },
    Cursor       { gui = "reverse", gui = "nocombine"  },
    CursorIM     { gui = "reverse", gui = "nocombine" },
    CursorLine   { bg = black.darken(20), gui = "nocombine" },
    CursorLineNr { bg = black, fg = yellow, gui = "nocombine,bold" },
    DiffAdd      { fg = lightGreen, gui = "nocombine,bold" },
    DiffChange   { fg = lightBlue, gui = "nocombine,bold" },
    DiffDelete   { fg = lightRed, gui = "nocombine,bold" },
    DiffText     { fg = lightPurple, gui = "nocombine,undercurl" },
    Directory    { fg = lightBlue, gui = "nocombine,bold" },
    EndOfBuffer  { fg = lightGrey, gui = "nocombine" },
    ErrorMsg     { bg = lightWhite, fg = red, gui = "nocombine" },
    FoldColumn   { fg = lightGrey, gui = "nocombine" },
    Folded       { gui = "nocombine,italic" },
    IncSearch    { bg = lightGreen, fg = black, gui = "nocombine,bold" },
    LineNr       { bg = black.lighten(5), fg = black.lighten(40), gui = "nocombine" },
    MatchParen   { bg = purple, fg = yellow, gui = "nocombine" },
    ModeMsg      { fg = lightGrey, gui = "nocombine" },
    MoreMsg      { fg = lightPurple, gui = "nocombine,bold" },
    MsgArea      { fg = lightGreen, gui = "nocombine,italic" },
    MsgSeparator { fg = yellow, gui = "nocombine" },
    NonText      { fg = grey, gui = "nocombine" },
    Normal       { bg = black, fg = white, gui = "nocombine" },
    NormalFloat  { bg = grey, gui = "nocombine" },
    NormalNC     { bg = lightBlack, fg = white, gui = "nocombine" },
    Pmenu        { bg = black.darken(20), fg = white, gui = "nocombine" },
    PmenuSbar    { bg = black.darken(40), gui = "nocombine" },
    PmenuSel     { bg = purple, fg = yellow, gui = "nocombine,bold" },
    PmenuThumb   { bg = lightYellow, fg = blue, gui = "nocombine" },
    Question     { fg = lightOrange, gui = "nocombine" },
    QuickFixLine { bg = purple, fg = yellow, gui = "nocombine" },
    Search       { bg = green, fg = white, gui = "nocombine,bold,italic" },
    SignColumn   { bg = black, gui = "nocombine,italic"  },
    SpecialKey   { fg = purple, gui = "nocombine" },
    SpellRare    { fg = lightBlue, gui = "nocombine,undercurl" },
    StatusLine   { bg = black.darken(20), gui = "nocombine" },
    StatusLineNC { bg = black, gui = "nocombine" },
    Substitute   { bg = blue, fg = lightCyan, gui = "nocombine" },
    TabLine      { bg = blue, fg = lightWhite, gui = "nocombine" },
    TabLineFill  { bg = grey, fg = black, gui = "nocombine" },
    TabLineSel   { Normal },
    TermCursor   { Cursor },
    TermCursorNC { bg = white, fg = black, gui = "nocombine" },
    Title        { fg = orange, gui = "nocombine" },
    VertSplit    { fg = yellow, gui = "nocombine" },
    Visual       { bg = blue, gui = "nocombine" },
    VisualNOS    { bg = lightCyan, gui = "nocombine" },
    WarningMsg   { bg = yellow, fg = black.darken(40), gui = "nocombine,bold,italic" },
    Whitespace   { fg = black.lighten(15), gui = "nocombine" },
    WildMenu     { bg = green, gui = "nocombine,bold" },
    lCursor      { gui = "nocombine,reverse,bold" },

    Constant       { fg = lightCyan, gui = "nocombine,bold" }, -- (preferred) any constant
    String         { fg = lightWhite, gui = "nocombine,italic" }, --   a string constant: "this is a string"
    Character      { fg = lightGreen, gui = "nocombine" }, --  a character constant: 'c', '\n'
    Number         { fg = lightRed, gui = "nocombine" }, --   a number constant: 234, 0xff
    Boolean        { fg = yellow, gui = "nocombine" }, --  a boolean constant: TRUE, false
    Float          { Number }, --    a floating point constant: 2.3e10

    Identifier     { fg = lightYellow, gui = "nocombine" }, -- (preferred) any variable name
    Function       { fg = cyan, gui = "nocombine,bold" }, -- function name (also: methods for classes)

    Statement      { fg = green, gui = "nocombine" }, -- (preferred) any statement
    Conditional    { fg = orange, gui = "nocombine" }, --  if, then, else, endif, switch, etc.
    Repeat         { fg = lightPurple, gui = "nocombine" }, --   for, do, while, etc.
    Label          { fg = red, gui = "nocombine" }, --    case, default, etc.
    Operator       { fg = lightOrange, gui = "nocombine" }, -- "sizeof", "+", "*", etc.
    Keyword        { fg = blue, gui = "nocombine" }, --  any other keyword
    Exception      { fg = red, gui = "nocombine,bold,undercurl" }, --  try, catch, throw

    PreProc        { fg = lightOrange, gui = "nocombine" }, -- (preferred) generic Preprocessor
    Include        { fg = blue, gui = "nocombine" }, --  preprocessor #include
    Define         { fg = purple, gui = "nocombine" }, --   preprocessor #define
    Macro          { Define }, --    same as Define
    PreCondit      { fg = white, gui = "nocombine,bold" }, --  preprocessor #if, #else, #endif, etc.

    Type           { fg = yellow, gui = "nocombine,bold" }, -- (preferred) int, long, char, etc.
    StorageClass   { fg = lightYellow, gui = "nocombine,bold" }, -- static, register, volatile, etc.
    Structure      { fg = lightCyan, gui = "nocombine,bold"}, --  struct, union, enum, etc.
    Typedef        { fg = lightGreen, gui = "nocombine" }, --  A typedef

    Special        { fg = lightPurple, gui = "nocombine,bold" }, -- (preferred) any special symbol
    SpecialChar    { fg = purple, gui = "nocombine" }, --  special character in a constant
    Tag            { fg = lightCyan, gui = "nocombine,underline" }, --    you can use CTRL-] on this
    Delimiter      { fg = lightGreen, gui = "nocombine,bold" }, --  character that needs attention
    SpecialComment { fg = green.desaturate(40), gui = "nocombine,italic"}, -- special things inside a comment
    Debug          { fg = orange, gui = "nocombine,bold" }, --    debugging statements

    Underlined { gui = "nocombine,underline" }, -- (preferred) text that stands out, HTML links
    Bold       { gui = "nocombine,bold" },
    Italic     { gui = "nocombine,italic" },

    Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|
    Error          { bg = red, fg = lightWhite, gui = "nocombine,bold,italic" }, -- (preferred) any erroneous construct
    Todo           { bg = blue, fg = lightWhite, gui = "nocombine,bold,italic" }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    LspDiagnosticsError               { fg = red.desaturate(60), gui = "nocombine,italic" }, -- used for "Error" diagnostic virtual text
    LspDiagnosticsErrorSign           { fg = red, gui = "nocombine,bold" }, -- used for "Error" diagnostic signs in sign column
    LspDiagnosticsErrorFloating       { Error }, -- used for "Error" diagnostic messages in the diagnostics float
    LspDiagnosticsWarning             { fg = yellow.desaturate(60), gui = "nocombine,italic" }, -- used for "Warning" diagnostic virtual text
    LspDiagnosticsWarningSign         { fg = yellow, gui = "nocombine,bold" }, -- used for "Warning" diagnostic signs in sign column
    LspDiagnosticsWarningFloating     { WarningMsg }, -- used for "Warning" diagnostic messages in the diagnostics float
    LspDiagnosticsInformation         { fg = lightBlue.desaturate(60), gui = "nocombine,italic" }, -- used for "Information" diagnostic virtual text
    LspDiagnosticsInformationSign     { fg = lightBlue, gui = "nocombine,bold" }, -- used for "Information" signs in sign column
    LspDiagnosticsInformationFloating { bg = blue, fg = white, gui = "nocombine,bold,italic" }, -- used for "Information" diagnostic messages in the diagnostics float
    LspDiagnosticsHint                { fg = lightGreen.desaturate(60), gui = "nocombine,italic" }, -- used for "Hint" diagnostic virtual text
    LspDiagnosticsHintSign            { fg = lightGreen, gui = "nocombine,bold" }, -- used for "Hint" diagnostic signs in sign column
    LspDiagnosticsHintFloating        { bg = lightGreen, fg = black.darken(40), gui = "nocombine,bold,italic" }, -- used for "Hint" diagnostic messages in the diagnostics float
    LspReferenceText                  { fg = lightPurple, gui = "nocombine,italic"}, -- used for highlighting "text" references
    LspReferenceRead                  { fg = lightGrey, gui = "nocombine,italic" }, -- used for highlighting "read" references
    LspReferenceWrite                 { fg = purple, gui = "nocombine,italic" }, -- used for highlighting "write" references

    TSError              { ErrorMsg }, -- For syntax/parser errors.
    TSPunctDelimiter     { Delimiter }, -- For delimiters ie: `.`
    TSPunctBracket       { fg = lightYellow, gui = "nocombine" }, -- For brackets and parens.
    TSPunctSpecial       { Special }, -- For special punctutation that does not fall in the catagories before.
    TSConstant           { Constant }, -- For constants
    TSConstBuiltin       { fg = cyan, gui = "nocombine,bold" }, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro         { fg = blue, gui = "nocombine,bold" }, -- For constants that are defined by macros: `NULL` in C.
    TSString             { String }, -- For strings.
    TSStringRegex        { fg = cyan, gui = "nocombine" }, -- For regexes.
    TSStringEscape       { fg = lightOrange, gui = "nocombine" }, -- For escape characters within a string.
    TSCharacter          { Character }, -- For characters.
    TSNumber             { Number }, -- For integers.
    TSBoolean            { Boolean }, -- For booleans.
    TSFloat              { Float }, -- For floats.
    TSFunction           { Function }, -- For function (calls and definitions).
    TSFuncBuiltin        { Special }, -- For builtin functions: `table.insert` in Lua.
    TSFuncMacro          { Macro }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSParameter          { fg = lightWhite, gui = "nocombine,bold" }, -- For parameters of a function.
    TSParameterReference { TSParameter, gui = "nocombine,undercurl", sp = purple }, -- For references to parameters of a function.
    TSMethod             { Function, fg = lightBlue }, -- For method calls and definitions.
    TSField              { TSMethod, fg = blue }, -- For fields.
    TSProperty           { TSField }, -- Same as `TSField`.
    TSConstructor        { TSMethod, gui = "nocombine,underline", sp = blue }, -- For constructor calls and definitions: `{ }` in Lua, and Java constructors.
    TSConditional        { Conditional }, -- For keywords related to conditionnals.
    TSRepeat             { Repeat }, -- For keywords related to loops.
    TSLabel              { Label }, -- For labels: `label:` in C and `:label:` in Lua.
    TSOperator           { Operator }, -- For any operator: `+`, but also `->` and `*` in C.
    TSKeyword            { Keyword }, -- For keywords that don't fall in previous categories.
    TSKeywordFunction    { Function }, -- For keywords used to define a fuction.
    TSException          { Exception }, -- For exception related keywords.
    TSType               { Type }, -- For types.
    TSTypeBuiltin        { Typedef }, -- For builtin types (you guessed it, right ?).
    TSNamespace          { Identifier }, -- For identifiers referring to modules and namespaces.
    TSInclude            { Include }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSAnnotation         { Special }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSText               { String }, -- For strings considered text in a markup language.
    TSStrong             { gui = "nocombine,bold" }, -- For text to be represented with strong.
    TSEmphasis           { gui = "nocombine,italic"  }, -- For text to be represented with emphasis.
    TSUnderline          { gui = "nocombine,underline" }, -- For text to be represented with an underline.
    TSTitle              { Title }, -- Text that is part of a title.
    TSLiteral            { String }, -- Literal text.
    TSURI                { gui = "underline", sp = lightBlue }, -- Any URI like a link or email.
    TSVariable           { fg = green, gui = "nocombine" }, -- Any variable name that does not have another highlight.
    TSVariableBuiltin    { fg = purple, gui = "nocombine,bold" }, -- Variable names that are defined by the languages, like `this` or `self`.

    Black { fg = black },
    BlackItalic { Black, gui = "nocombine,italic" },
    BlackBG { bg = black },
    Blue { fg = blue },
    BlueItalic { Blue, gui = "nocombine,italic" },
    BlueBG { bg = blue },
    Cyan { fg = cyan },
    CyanItalic { Cyan, gui = "nocombine,italic" },
    CyanBG { bg = cyan },
    Green { fg = green },
    GreenItalic { Green, gui = "nocombine,italic" },
    GreenBG { bg = green },
    Grey { fg = grey },
    GreyItalic { Grey, gui = "nocombine,italic" },
    GreyBG { bg = grey },
    Orange { fg = orange },
    OrangeItalic { Orange, gui = "nocombine,italic" },
    OrangeBG { bg = orange },
    Purple { fg = purple },
    PurpleItalic { Purple, gui = "nocombine,italic" },
    PurpleBG { bg = purple },
    Red { fg = red },
    RedItalic { Red, gui = "nocombine,italic" },
    RedBG { bg = red },
    White { fg = white },
    WhiteItalic { White, gui = "nocombine,italic" },
    WhiteBG { bg = white },
    Yellow { fg = yellow },
    YellowItalic { Yellow, gui = "nocombine,italic" },
    YellowBG { bg = yellow },

    LightBlack { fg = lightBlack },
    LightBlackItalic { LightBlack, gui = "nocombine,italic" },
    LightBlackBG { bg = lightBlack },
    LightBlue { fg = lightBlue },
    LightBlueItalic { LightBlue, gui = "nocombine,italic" },
    LightBlueBG { bg = lightBlue },
    LightCyan { fg = lightCyan },
    LightCyanItalic { LightCyan, gui = "nocombine,italic" },
    LightCyanBG { bg = lightCyan },
    LightGreen { fg = lightGreen },
    LightGreenItalic { LightGreen, gui = "nocombine,italic" },
    LightGreenBG { bg = lightGreen },
    LightGrey { fg = lightGrey },
    LightGreyItalic { LightGrey, gui = "nocombine,italic" },
    LightGreyBG { bg = lightGrey },
    LightOrange { fg = lightOrange },
    LightOrangeItalic { LightOrange, gui = "nocombine,italic" },
    LightOrangeBG { bg = lightOrange },
    LightPurple { fg = lightPurple },
    LightPurpleItalic { LightPurple, gui = "nocombine,italic" },
    LightPurpleBG { bg = lightPurple },
    LightRed { fg = lightRed },
    LightRedItalic { LightRed, gui = "nocombine,italic" },
    LightRedBG { bg = lightRed },
    LightWhite { fg = lightWhite },
    LightWhiteItalic { LightWhite, gui = "nocombine,italic" },
    LightWhiteBG { bg = lightWhite },
    LightYellow { fg = lightYellow },
    LightYellowItalic { LightYellow, gui = "nocombine,italic" },
    LightYellowBG { bg = lightYellow },
  }
end)
