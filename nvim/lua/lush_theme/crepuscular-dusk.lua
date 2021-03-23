local lush = require('lush')

package.loaded['lush_theme.crepuscular-colours'] = nil

local colours = require('lush_theme.crepuscular-colours')
local base = require('lush_theme.crepuscular-base')

local theme = lush.merge({
    base,
    lush(function()
        return {
            ColorColumn {bg = colours.black.darken(20), gui = "nocombine"},
            Comment {fg = colours.black.lighten(15), gui = "nocombine,italic"},
            CursorLine {bg = colours.black.darken(20), gui = "nocombine"},
            CursorLineNr {bg = colours.black, fg = colours.yellow, gui = "nocombine,bold"},
            DiffAdd {bg = colours.green, fg = colours.lightGreen, gui = "nocombine,bold"},
            DiffChange {bg = colours.blue, fg = colours.lightBlue, gui = "nocombine,bold"},
            DiffDelete {bg = colours.red, fg = colours.lightRed, gui = "nocombine,bold"},
            DiffText {
                bg = colours.purple,
                fg = colours.lightPurple,
                gui = "nocombine,bold,undercurl"
            }, IncSearch {bg = colours.lightGreen, fg = colours.black, gui = "nocombine,bold"},
            LineNr {
                bg = colours.black.lighten(5),
                fg = colours.black.lighten(40),
                gui = "nocombine"
            }, MatchParen {bg = colours.purple, fg = colours.yellow, gui = "nocombine"},
            ModeMsg {fg = colours.lightGrey, gui = "nocombine"},
            MoreMsg {fg = colours.lightPurple, gui = "nocombine,bold"},
            MsgArea {fg = colours.lightYellow, gui = "nocombine,italic"},
            MsgSeparator {fg = colours.lightGreen, gui = "nocombine"},
            NonText {fg = colours.grey, gui = "nocombine"},
            Normal {bg = colours.black, fg = colours.white, gui = "nocombine"},
            NormalFloat {bg = colours.black.darken(40), gui = "nocombine"},
            NormalNC {bg = colours.lightBlack, fg = colours.white, gui = "nocombine"},
            Pmenu {bg = colours.black.darken(20), fg = colours.white, gui = "nocombine"},
            PmenuSbar {bg = colours.black.darken(40), gui = "nocombine"},
            PmenuSel {bg = colours.purple, fg = colours.yellow, gui = "nocombine,bold"},
            QuickFixLine {bg = colours.purple, fg = colours.yellow, gui = "nocombine"},
            SignColumn {bg = colours.black, gui = "nocombine,italic"},
            SpellRare {fg = colours.lightBlue, gui = "nocombine,undercurl"},
            StatusLine {bg = colours.black.darken(20), gui = "nocombine"},
            StatusLineNC {bg = colours.black, gui = "nocombine"},
            Substitute {bg = colours.blue, fg = colours.lightCyan, gui = "nocombine"},
            TabLine {bg = colours.blue, fg = colours.lightWhite, gui = "nocombine"},
            TabLineFill {bg = colours.grey, fg = colours.black, gui = "nocombine"},
            TabLineSel {Normal},
            TermCursorNC {bg = colours.white, fg = colours.black, gui = "nocombine"},
            VertSplit {fg = colours.yellow, gui = "nocombine"},
            Visual {bg = colours.blue, gui = "nocombine"},
            VisualNOS {bg = colours.lightCyan, gui = "nocombine"},
            Whitespace {fg = colours.black.lighten(15), gui = "nocombine"},
            WildMenu {bg = colours.green, gui = "nocombine,bold"},

            Constant {fg = colours.lightCyan, gui = "nocombine,bold"},
            String {fg = colours.lightWhite, gui = "nocombine,italic"},
            Function {fg = colours.cyan, gui = "nocombine,bold"},
            PreCondit {fg = colours.white, gui = "nocombine,bold"},
            SpecialComment {fg = colours.green.desaturate(40), gui = "nocombine,italic"},
            StorageClass {fg = colours.lightYellow, gui = "nocombine,bold"},
            Structure {fg = colours.lightCyan, gui = "nocombine,bold"},
            Tag {fg = colours.lightCyan, gui = "nocombine,underline"},
            Type {fg = colours.yellow, gui = "nocombine,bold"},
            Typedef {fg = colours.lightGreen, gui = "nocombine"},

            TSPunctBracket {fg = colours.orange.lighten(20), gui = "nocombine"},
            TSConstant {Constant},
            TSString {String},
            TSFunction {Function},
            TSParameter {fg = colours.lightBlack.lighten(20), gui = "nocombine,bold"},
            TSParameterReference {
                TSParameter,
                gui = "nocombine,undercurl",
                sp = colours.purple
            },
            TSMethod {Function, fg = colours.lightBlue},
            TSField {TSMethod, fg = colours.blue},
            TSProperty {TSField},
            TSConstructor {TSMethod, gui = "nocombine,underline", sp = colours.blue},
            TSKeywordFunction {Function},
            TSType {Type},
            TSTypeBuiltin {Typedef},
            TSText {String},
            TSLiteral {String},
            LspDiagnosticsVirtualTextError {
                fg = colours.red.desaturate(60),
                gui = "nocombine,italic"
            }, LspDiagnosticsVirtualTextHint {
                fg = colours.lightGreen.desaturate(60),
                gui = "nocombine,italic"
            }, LspDiagnosticsVirtualTextInformation {
                fg = colours.lightBlue.desaturate(60),
                gui = "nocombine,italic"
            }, LspDiagnosticsVirtualTextWarning {
                fg = colours.yellow.desaturate(60),
                gui = "nocombine,italic"
            }, GitSignsAddSign {SignColumn, fg = colours.lightGreen, gui = "nocombine"},
            GitSignsChangeSign {SignColumn, fg = colours.lightBlue, gui = "nocombine"},
            GitSignsDeleteSign {SignColumn, fg = colours.lightRed, gui = "nocombine"},
            GitSignsAddNr {LineNr, fg = colours.lightGreen, gui = "nocombine"},
            GitSignsChangeNr {LineNr, fg = colours.lightBlue, gui = "nocombine"},
            GitSignsDeleteNr {LineNr, fg = colours.lightRed, gui = "nocombine"}
        }
    end)
})

return theme
