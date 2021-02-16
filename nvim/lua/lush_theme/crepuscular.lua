local lush = require('lush')
local hsl = lush.hsl
local background = vim.o.background

-- CREPUSCULAR -------------------------

-- Colours
local black = hsl(275, 20, 10) -- original "#111224"
local blue = hsl(215, 75, 45) -- original "#155199"
local cyan = hsl(190, 45, 45) -- original "#6187ae"
local green = hsl(130, 30, 30) -- original "#354e39"
local grey = hsl(315, 5, 30) -- original "#786674"
local orange = hsl(20, 75, 40) -- original "#ec722f"
local purple = hsl(260, 60, 45) -- original "#673a5b"
local red = hsl(350, 60, 40) -- original "#a95062"
local white = hsl(30, 60, 80) -- original "#ebd3b9"
local yellow = hsl(40, 100, 60) -- original "#ffc346"

local lightBlack = hsl(275, 25, 15) -- original "#222035"
local lightBlue = hsl(215, 75, 60) -- original "#356ea5"
local lightCyan = hsl(190, 60, 75) -- original "#83a0c8"
local lightGreen = hsl(85, 30, 45) -- original "#5e723f"
local lightGrey = hsl(310, 10, 60) -- original "#9f8d9d"
local lightOrange = hsl(25, 100, 60) -- original "#fe882e"
local lightPurple = hsl(260, 45, 60) -- original "#9f7195"
local lightRed = hsl(0, 45, 60) -- original "#c5696e"
local lightWhite = hsl(45, 70, 95) -- original "#fcf9f0"
local lightYellow = hsl(40, 100, 75) -- original "#ffd782"

local base = {
    Black {fg = black}, BlackItalic {Black, gui = "nocombine,italic"},
    BlackBG {bg = black}, Blue {fg = blue},
    BlueItalic {Blue, gui = "nocombine,italic"}, BlueBG {bg = blue},
    Cyan {fg = cyan}, CyanItalic {Cyan, gui = "nocombine,italic"},
    CyanBG {bg = cyan}, Green {fg = green},
    GreenItalic {Green, gui = "nocombine,italic"}, GreenBG {bg = green},
    Grey {fg = grey}, GreyItalic {Grey, gui = "nocombine,italic"},
    GreyBG {bg = grey}, Orange {fg = orange},
    OrangeItalic {Orange, gui = "nocombine,italic"}, OrangeBG {bg = orange},
    Purple {fg = purple}, PurpleItalic {Purple, gui = "nocombine,italic"},
    PurpleBG {bg = purple}, Red {fg = red},
    RedItalic {Red, gui = "nocombine,italic"}, RedBG {bg = red},
    White {fg = white}, WhiteItalic {White, gui = "nocombine,italic"},
    WhiteBG {bg = white}, Yellow {fg = yellow},
    YellowItalic {Yellow, gui = "nocombine,italic"}, YellowBG {bg = yellow},

    LightBlack {fg = lightBlack},
    LightBlackItalic {LightBlack, gui = "nocombine,italic"},
    LightBlackBG {bg = lightBlack}, LightBlue {fg = lightBlue},
    LightBlueItalic {LightBlue, gui = "nocombine,italic"},
    LightBlueBG {bg = lightBlue}, LightCyan {fg = lightCyan},
    LightCyanItalic {LightCyan, gui = "nocombine,italic"},
    LightCyanBG {bg = lightCyan}, LightGreen {fg = lightGreen},
    LightGreenItalic {LightGreen, gui = "nocombine,italic"},
    LightGreenBG {bg = lightGreen}, LightGrey {fg = lightGrey},
    LightGreyItalic {LightGrey, gui = "nocombine,italic"},
    LightGreyBG {bg = lightGrey}, LightOrange {fg = lightOrange},
    LightOrangeItalic {LightOrange, gui = "nocombine,italic"},
    LightOrangeBG {bg = lightOrange}, LightPurple {fg = lightPurple},
    LightPurpleItalic {LightPurple, gui = "nocombine,italic"},
    LightPurpleBG {bg = lightPurple}, LightRed {fg = lightRed},
    LightRedItalic {LightRed, gui = "nocombine,italic"},
    LightRedBG {bg = lightRed}, LightWhite {fg = lightWhite},
    LightWhiteItalic {LightWhite, gui = "nocombine,italic"},
    LightWhiteBG {bg = lightWhite}, LightYellow {fg = lightYellow},
    LightYellowItalic {LightYellow, gui = "nocombine,italic"},
    LightYellowBG {bg = lightYellow}, Ignore {},
    Error {bg = red, fg = lightWhite, gui = "nocombine,bold,italic"},
    Todo {bg = blue, fg = lightWhite, gui = "nocombine,bold,italic"},
    ErrorMsg {
        bg = lightWhite,
        fg = red,
        gui = "nocombine,bold,italic,undercurl",
        sp = "red"
    },
    WarningMsg {
        bg = yellow,
        fg = black.darken(40),
        gui = "nocombine,bold,italic"
    }, Bold {gui = "nocombine,bold"}, Italic {gui = "nocombine,italic"},
    Debug {fg = orange, gui = "nocombine,bold"},
    Delimiter {fg = lightGreen, gui = "nocombine,bold"},
    Special {fg = lightPurple, gui = "nocombine,bold"},
    SpecialChar {fg = purple, gui = "nocombine"},
    Underlined {gui = "nocombine,underline"},

    Conceal {bg = grey, fg = lightGrey, gui = "nocombine"},
    Cursor {gui = "nocombine,reverse"}, CursorIM {gui = "nocombine,reverse"},
    Directory {fg = lightBlue, gui = "nocombine,bold"},
    EndOfBuffer {fg = lightGrey, gui = "nocombine"},
    FoldColumn {fg = lightGrey, gui = "nocombine"},
    Folded {gui = "nocombine,italic"},
    PmenuThumb {bg = lightYellow, fg = blue, gui = "nocombine"},
    Question {fg = lightOrange, gui = "nocombine"},
    Search {bg = green, fg = white, gui = "nocombine,bold,italic"},
    SpecialKey {fg = purple, gui = "nocombine"},
    TabLineFill {bg = grey, fg = black, gui = "nocombine"},
    TabLineFill {bg = lightGrey, fg = black, gui = "nocombine"},
    TabLineSel {Normal}, Title {fg = orange, gui = "nocombine"},
    lCursor {gui = "nocombine,reverse,bold"},

    Boolean {fg = yellow, gui = "nocombine"},
    Character {fg = lightGreen, gui = "nocombine"},
    Conditional {fg = orange, gui = "nocombine"},
    Define {fg = purple, gui = "nocombine"},
    Exception {fg = red, gui = "nocombine,bold,undercurl"}, Float {Number},
    Identifier {fg = lightYellow, gui = "nocombine"},
    Include {fg = blue, gui = "nocombine"},
    Keyword {fg = blue, gui = "nocombine"}, Label {fg = red, gui = "nocombine"},
    Macro {Define}, Number {fg = lightRed, gui = "nocombine"},
    Operator {fg = lightOrange, gui = "nocombine"},
    PreProc {fg = lightOrange, gui = "nocombine"},
    Repeat {fg = lightPurple, gui = "nocombine"},
    Statement {fg = green, gui = "nocombine"},

    TSAnnotation {Special}, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSBoolean {Boolean}, -- For booleans.
    TSCharacter {Character}, -- For characters.
    TSConditional {Conditional}, -- For keywords related to conditionnals.
    TSConstBuiltin {fg = cyan, gui = "nocombine,bold"}, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro {fg = blue, gui = "nocombine,bold"}, -- For constants that are defined by macros: `NULL` in C.
    TSEmphasis {gui = "nocombine,italic"}, -- For text to be represented with emphasis.
    TSError {ErrorMsg}, -- For syntax/parser errors.
    TSException {Exception}, -- For exception related keywords.
    TSFloat {Float}, -- For floats.
    TSFuncBuiltin {Special}, -- For builtin functions: `table.insert` in Lua.
    TSFuncMacro {Macro}, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSInclude {Include}, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSKeyword {Keyword}, -- For keywords that don't fall in previous categories.
    TSLabel {Label}, -- For labels: `label:` in C and `:label:` in Lua.
    TSNamespace {Identifier}, -- For identifiers referring to modules and namespaces.
    TSNumber {Number}, -- For integers.
    TSOperator {Operator}, -- For any operator: `+`, but also `->` and `*` in C.
    TSPunctDelimiter {Delimiter}, -- For delimiters ie: `.`
    TSPunctSpecial {Special}, -- For special punctutation that does not fall in the catagories before.
    TSRepeat {Repeat}, -- For keywords related to loops.
    TSStringEscape {fg = lightOrange, gui = "nocombine"}, -- For escape characters within a string.
    TSStringRegex {fg = cyan, gui = "nocombine"}, -- For regexes.
    TSStrong {gui = "nocombine,bold"}, -- For text to be represented with strong.
    TSTitle {Title}, -- Text that is part of a title.
    TSURI {gui = "underline", sp = lightBlue}, -- Any URI like a link or email.
    TSUnderline {gui = "nocombine,underline"}, -- For text to be represented with an underline.
    TSVariable {fg = green, gui = "nocombine"}, -- Any variable name that does not have another highlight.
    TSVariableBuiltin {fg = purple, gui = "nocombine,bold"}, -- Variable names that are defined by the languages, like `this` or `self`.

    LspDiagnosticsFloatingError {Error}, LspDiagnosticsFloatingHint {
        bg = lightGreen,
        fg = black.darken(40),
        gui = "nocombine,bold,italic"
    }, LspDiagnosticsFloatingInformation {
        bg = blue,
        fg = white,
        gui = "nocombine,bold,italic"
    }, LspDiagnosticsFloatingWarning {WarningMsg},
    LspDiagnosticsSignError {fg = red, gui = "nocombine,bold"},
    LspDiagnosticsSignHint {fg = lightGreen, gui = "nocombine,bold"},
    LspDiagnosticsSignInformation {fg = lightBlue, gui = "nocombine,bold"},
    LspDiagnosticsSignWarning {fg = yellow, gui = "nocombine,bold"},
    LspDiagnosticsUnderlineError {Underlined, sp = red},
    LspDiagnosticsUnderlineHint {Underlined, sp = lightGreen},
    LspDiagnosticsUnderlineInformation {Underlined, sp = lightBlue},
    LspDiagnosticsUnderlineWarning {Underlined, sp = yellow},
    LspReferenceRead {fg = lightGrey, gui = "nocombine,italic"},
    LspReferenceText {fg = lightPurple, gui = "nocombine,italic"},
    LspReferenceWrite {fg = purple, gui = "nocombine,italic"}
}

local dark = {
    ColorColumn {bg = black.darken(20), gui = "nocombine"},
    Comment {fg = black.lighten(15), gui = "nocombine,italic"},
    CursorLine {bg = black.darken(20), gui = "nocombine"},
    CursorLineNr {bg = black, fg = yellow, gui = "nocombine,bold"},
    DiffAdd {bg = green, fg = lightGreen, gui = "nocombine,bold"},
    DiffChange {bg = blue, fg = lightBlue, gui = "nocombine,bold"},
    DiffDelete {bg = red, fg = lightRed, gui = "nocombine,bold"},
    DiffText {bg = purple, fg = lightPurple, gui = "nocombine,bold,undercurl"},
    IncSearch {bg = lightGreen, fg = black, gui = "nocombine,bold"},
    LineNr {bg = black.lighten(5), fg = black.lighten(40), gui = "nocombine"},
    MatchParen {bg = purple, fg = yellow, gui = "nocombine"},
    ModeMsg {fg = lightGrey, gui = "nocombine"},
    MoreMsg {fg = lightPurple, gui = "nocombine,bold"},
    MsgArea {fg = lightYellow, gui = "nocombine,italic"},
    MsgSeparator {fg = lightGreen, gui = "nocombine"},
    NonText {fg = grey, gui = "nocombine"},
    Normal {bg = black, fg = white, gui = "nocombine"},
    NormalFloat {bg = grey, gui = "nocombine"},
    NormalNC {bg = lightBlack, fg = white, gui = "nocombine"},
    Pmenu {bg = black.darken(20), fg = white, gui = "nocombine"},
    PmenuSbar {bg = black.darken(40), gui = "nocombine"},
    PmenuSel {bg = purple, fg = yellow, gui = "nocombine,bold"},
    QuickFixLine {bg = purple, fg = yellow, gui = "nocombine"},
    SignColumn {bg = black, gui = "nocombine,italic"},
    SpellRare {fg = lightBlue, gui = "nocombine,undercurl"},
    StatusLine {bg = black.darken(20), gui = "nocombine"},
    StatusLineNC {bg = black, gui = "nocombine"},
    Substitute {bg = blue, fg = lightCyan, gui = "nocombine"},
    TabLine {bg = blue, fg = lightWhite, gui = "nocombine"},
    TabLineFill {bg = grey, fg = black, gui = "nocombine"}, TabLineSel {Normal},
    TermCursorNC {bg = white, fg = black, gui = "nocombine"},
    VertSplit {fg = yellow, gui = "nocombine"},
    Visual {bg = blue, gui = "nocombine"},
    VisualNOS {bg = lightCyan, gui = "nocombine"},
    Whitespace {fg = black.lighten(15), gui = "nocombine"},
    WildMenu {bg = green, gui = "nocombine,bold"},

    Constant {fg = lightCyan, gui = "nocombine,bold"},
    String {fg = lightWhite, gui = "nocombine,italic"},
    Function {fg = cyan, gui = "nocombine,bold"},
    PreCondit {fg = white, gui = "nocombine,bold"},
    SpecialComment {fg = green.desaturate(40), gui = "nocombine,italic"},
    StorageClass {fg = lightYellow, gui = "nocombine,bold"},
    Structure {fg = lightCyan, gui = "nocombine,bold"},
    Tag {fg = lightCyan, gui = "nocombine,underline"},
    Type {fg = yellow, gui = "nocombine,bold"},
    Typedef {fg = lightGreen, gui = "nocombine"},


    LspDiagnosticsVirtualTextError {
        fg = red.desaturate(60),
        gui = "nocombine,italic"
    }, LspDiagnosticsVirtualTextHint {
        fg = lightGreen.desaturate(60),
        gui = "nocombine,italic"
    }, LspDiagnosticsVirtualTextInformation {
        fg = lightBlue.desaturate(60),
        gui = "nocombine,italic"
    }, LspDiagnosticsVirtualTextWarning {
        fg = yellow.desaturate(60),
        gui = "nocombine,italic"
    },

    GitSignsAddSign {SignColumn, fg = lightGreen, gui = "nocombine"},
    GitSignsChangeSign {SignColumn, fg = lightBlue, gui = "nocombine"},
    GitSignsDeleteSign {SignColumn, fg = lightRed, gui = "nocombine"},
    GitSignsAddNr {LineNr, fg = lightGreen, gui = "nocombine"},
    GitSignsChangeNr {LineNr, fg = lightBlue, gui = "nocombine"},
    GitSignsDeleteNr {LineNr, fg = lightRed, gui = "nocombine"}
}

local light = {
    ColorColumn {bg = white.abs_lighten(10), gui = "nocombine"},
    Comment {fg = white.abs_darken(20), gui = "nocombine,italic"},
    CursorLine {bg = white.abs_lighten(10), gui = "nocombine"},
    CursorLineNr {bg = yellow, fg = purple, gui = "nocombine,bold"},
    DiffAdd {bg = lightGreen, fg = green, gui = "nocombine,bold"},
    DiffChange {bg = lightBlue, fg = blue, gui = "nocombine,bold"},
    DiffDelete {bg = lightRed, fg = red, gui = "nocombine,bold"},
    DiffText {bg = lightCyan, fg = cyan, gui = "nocombine,bold,undercurl"},
    IncSearch {bg = lightGreen, fg = lightBlack, gui = "nocombine,bold"},
    LineNr {
        bg = white.abs_lighten(5),
        fg = white.abs_darken(40),
        gui = "nocombine"
    }, MatchParen {bg = lightYellow, fg = purple, gui = "nocombine"},
    ModeMsg {fg = grey, gui = "nocombine"},
    MoreMsg {fg = cyan, gui = "nocombine,bold"},
    MsgArea {fg = purple, gui = "nocombine,italic"},
    MsgSeparator {fg = green, gui = "nocombine"},
    NonText {fg = lightGrey, gui = "nocombine"},
    Normal {bg = lightWhite, fg = grey, gui = "nocombine"},
    NormalFloat {bg = white.abs_lighten(10), gui = "nocombine"},
    NormalNC {bg = white.abs_lighten(5), fg = lightBlack, gui = "nocombine"},
    Pmenu {bg = lightWhite.abs_lighten(10), fg = grey, gui = "nocombine"},
    PmenuSbar {bg = white.abs_lighten(10), gui = "nocombine"},
    PmenuSel {bg = lightCyan, fg = black, gui = "nocombine,bold"},
    QuickFixLine {bg = cyan, fg = lightWhite.abs_lighten(10), gui = "nocombine"},
    SignColumn {bg = lightWhite, gui = "nocombine,italic"},
    SpellRare {fg = blue, gui = "nocombine,undercurl"},
    StatusLine {bg = white.abs_lighten(10), gui = "nocombine"},
    StatusLineNC {bg = white.abs_lighten(5), gui = "nocombine"},
    Substitute {bg = lightCyan, fg = blue, gui = "nocombine"},
    TabLine {bg = lightBlue, fg = lightWhite, gui = "nocombine"},
    TabLineFill {bg = lightGrey, fg = black, gui = "nocombine"},
    TabLineSel {Normal},
    TermCursorNC {bg = black, fg = white, gui = "nocombine"},
    VertSplit {fg = orange, gui = "nocombine"},
    Visual {bg = lightCyan, gui = "nocombine"},
    VisualNOS {bg = cyan, gui = "nocombine"},
    Whitespace {fg = lightWhite.abs_lighten(10), gui = "nocombine"},
    WildMenu {bg = lightGreen, gui = "nocombine,bold"},

    Constant {fg = cyan, gui = "nocombine,bold"},
    String {fg = black, gui = "nocombine,italic"},
    Function {fg = lightBlue, gui = "nocombine,bold"},
    PreCondit {fg = lightBlack.lighten(20), gui = "nocombine,bold"},
    SpecialComment {
        fg = lightGreen.lighten(20).desaturate(40),
        gui = "nocombine,italic"
    },
    StorageClass {fg = orange.lighten(20), gui = "nocombine,bold"},
    Structure {fg = lightCyan.darken(20), gui = "nocombine,bold"},
    Tag {fg = cyan, gui = "nocombine,bold,underline"},
    Type {fg = yellow.darken(20), gui = "nocombine,bold"},
    Typedef {fg = lightGreen, gui = "nocombine,bold"},

    TSPunctBracket {fg = orange.lighten(20), gui = "nocombine"}, -- For brackets and parens.
    TSConstant {Constant}, -- For constants
    TSString {String}, -- For strings.
    TSFunction {Function}, -- For function (calls and definitions).
    TSParameter {fg = lightBlack.lighten(20), gui = "nocombine,bold"}, -- For parameters of a function.
    TSParameterReference {TSParameter, gui = "nocombine,undercurl", sp = purple}, -- For references to parameters of a function.
    TSMethod {Function, fg = lightBlue}, -- For method calls and definitions.
    TSField {TSMethod, fg = blue}, -- For fields.
    TSProperty {TSField}, -- Same as `TSField`.
    TSConstructor {TSMethod, gui = "nocombine,underline", sp = blue}, -- For constructor calls and definitions: `{ }` in Lua, and Java constructors.
    TSKeywordFunction {Function}, -- For keywords used to define a fuction.
    TSType {Type}, -- For types.
    TSTypeBuiltin {Typedef}, -- For builtin types (you guessed it, right ?).
    TSText {String}, -- For strings considered text in a markup language.
    TSLiteral {String}, -- Literal text.

    LspDiagnosticsVirtualTextError {
        fg = lightRed.desaturate(40),
        gui = "nocombine,italic"
    },
    LspDiagnosticsVirtualTextWarning {
        fg = lightYellow.darken(20).desaturate(20),
        gui = "nocombine,italic"
    },
    LspDiagnosticsVirtualTextInformation {
        fg = lightBlue.desaturate(40),
        gui = "nocombine,italic"
    },
    LspDiagnosticsVirtualTextHint {
        fg = lightGreen.desaturate(40),
        gui = "nocombine,italic"
    },

    GitSignsAddSign {SignColumn, fg = lightGreen, gui = "nocombine"},
    GitSignsChangeSign {SignColumn, fg = lightBlue, gui = "nocombine"},
    GitSignsDeleteSign {SignColumn, fg = lightRed, gui = "nocombine"},
    GitSignsAddNr {LineNr, fg = lightGreen, gui = "nocombine"},
    GitSignsChangeNr {LineNr, fg = lightBlue, gui = "nocombine"},
    GitSignsDeleteNr {LineNr, fg = lightRed, gui = "nocombine"}
}

-- Theme
return lush(function()
    if background == "dark" then
        for k, v in pairs(base) do dark[k] = v end
        return dark
    else
        for k, v in pairs(base) do light[k] = v end
        return light
    end
end)
