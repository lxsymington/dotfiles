local lush = require('lush')

package.loaded['crepuscular.colours'] = nil
package.loaded['crepuscular.base'] = nil

local colours = require('crepuscular.colours')
local base = require('crepuscular.base')

local theme = lush.merge({
	base,
	lush(function()
		return {
			ColorColumn({ bg = colours.white.abs_lighten(10), gui = 'nocombine' }),
			Comment({ fg = colours.white.abs_darken(20), gui = 'nocombine,italic' }),
			CursorLine({ bg = colours.white.abs_lighten(10), gui = 'nocombine' }),
			CursorLineNr({ bg = colours.yellow, fg = colours.purple, gui = 'nocombine,bold' }),
			DiffAdd({
				bg = colours.lightGreen.saturation(36).lightness(88),
				gui = 'nocombine,bold',
			}),
			DiffChange({
				bg = colours.lightBlue.saturation(36).lightness(88),
				gui = 'nocombine,bold',
			}),
			DiffDelete({
				bg = colours.lightRed.saturation(36).lightness(88),
				fg = colours.lightRed.saturation(60).lightness(48),
				gui = 'nocombine,bold',
			}),
			DiffText({
				bg = colours.lightYellow.saturation(36).lightness(88),
				gui = 'nocombine,bold,undercurl',
			}),
			IncSearch({
				bg = colours.lightGreen,
				fg = colours.lightBlack,
				gui = 'nocombine,bold',
			}),
			LineNr({
				bg = colours.white.abs_lighten(5),
				fg = colours.white.abs_darken(40),
				gui = 'nocombine',
			}),
			MatchParen({ bg = colours.lightYellow, fg = colours.purple, gui = 'nocombine' }),
			ModeMsg({ fg = colours.grey, gui = 'nocombine' }),
			MoreMsg({ fg = colours.cyan, gui = 'nocombine,bold' }),
			MsgArea({ fg = colours.purple, gui = 'nocombine,italic' }),
			MsgSeparator({ fg = colours.green, gui = 'nocombine' }),
			NonText({ fg = colours.lightGrey, gui = 'nocombine' }),
			Normal({ bg = colours.lightWhite, fg = colours.grey, gui = 'nocombine' }),
			NormalFloat({ bg = colours.white.abs_lighten(10), gui = 'nocombine' }),
			NormalNC({
				bg = colours.white.abs_lighten(10),
				fg = colours.lightBlack,
				gui = 'nocombine',
			}),
			Pmenu({
				bg = colours.lightWhite.abs_lighten(10),
				fg = colours.grey,
				gui = 'nocombine',
			}),
			PmenuSbar({ bg = colours.white.abs_lighten(10), gui = 'nocombine' }),
			PmenuSel({ bg = colours.lightCyan, fg = colours.black, gui = 'nocombine,bold' }),
			QuickFixLine({
				bg = colours.cyan,
				fg = colours.lightWhite.abs_lighten(10),
				gui = 'nocombine',
			}),
			SignColumn({ bg = colours.lightWhite, gui = 'nocombine,italic' }),
			SpellBad({
				bg = colours.orange.saturation(36).lightness(88),
				gui = 'nocombine,undercurl',
			}),
			SpellCap({
				bg = colours.lightPurple.saturation(36).lightness(88),
				gui = 'nocombine,undercurl',
			}),
			SpellLocal({
				bg = colours.lightCyan.saturation(36).lightness(88),
				gui = 'nocombine,undercurl',
			}),
			SpellRare({
				bg = colours.lightOrange.saturation(36).lightness(88),
				gui = 'nocombine,undercurl',
			}),
			StatusLine({ bg = colours.white.abs_lighten(10), gui = 'nocombine' }),
			StatusLineNC({ bg = colours.white.abs_lighten(5), gui = 'nocombine' }),
			Substitute({ bg = colours.lightCyan, fg = colours.blue, gui = 'nocombine' }),
			TabLine({ bg = colours.lightBlue, fg = colours.lightWhite, gui = 'nocombine' }),
			TabLineFill({ bg = colours.lightGrey, fg = colours.black, gui = 'nocombine' }),
			TabLineSel({ Normal }),
			TermCursorNC({ bg = colours.black, fg = colours.white, gui = 'nocombine' }),
			VertSplit({ fg = colours.orange, gui = 'nocombine' }),
			Visual({ bg = colours.lightCyan, gui = 'nocombine' }),
			VisualNOS({ bg = colours.cyan, gui = 'nocombine' }),
			Whitespace({ fg = colours.lightWhite.abs_lighten(10), gui = 'nocombine' }),
			WildMenu({ bg = colours.lightGreen, gui = 'nocombine,bold' }),

			Constant({ fg = colours.cyan, gui = 'nocombine,bold' }),
			String({ fg = colours.black, gui = 'nocombine,italic' }),
			Function({ fg = colours.lightBlue, gui = 'nocombine,bold' }),
			PreCondit({ fg = colours.lightBlack.lighten(20), gui = 'nocombine,bold' }),
			SpecialComment({
				fg = colours.lightGreen.lighten(20).desaturate(40),
				gui = 'nocombine,italic',
			}),
			StorageClass({ fg = colours.orange.lighten(20), gui = 'nocombine,bold' }),
			Structure({ fg = colours.lightCyan.darken(20), gui = 'nocombine,bold' }),
			Tag({ fg = colours.cyan, gui = 'nocombine,bold,underline' }),
			Type({ fg = colours.yellow.darken(20), gui = 'nocombine,bold' }),
			Typedef({ fg = colours.lightGreen, gui = 'nocombine,bold' }),

			TSPunctBracket({ fg = colours.orange.lighten(20), gui = 'nocombine' }),
			TSConstant({ Constant }),
			TSString({ String }),
			TSFunction({ Function }),
			TSParameter({ fg = colours.lightBlack.lighten(20), gui = 'nocombine,bold' }),
			TSParameterReference({
				TSParameter,
				gui = 'nocombine,undercurl',
				sp = colours.purple,
			}),
			TSMethod({ Function, fg = colours.lightBlue }),
			TSField({ TSMethod, fg = colours.blue }),
			TSProperty({ TSField }),
			TSConstructor({ TSMethod, gui = 'nocombine,underline', sp = colours.blue }),
			TSKeywordFunction({ Function }),
			TSType({ Type }),
			TSTypeBuiltin({ Typedef }),
			TSText({ String }),
			TSLiteral({ String }),

			DiagnosticVirtualTextError({
				bg = colours.lightRed.saturation(36).lightness(88),
				fg = colours.lightRed.saturation(60).lightness(48),
				gui = 'nocombine,italic',
			}),
			DiagnosticVirtualTextWarn({
				bg = colours.lightYellow.saturation(36).lightness(88),
				fg = colours.lightYellow.saturation(60).lightness(48),
				gui = 'nocombine,italic',
			}),
			DiagnosticVirtualTextInfo({
				bg = colours.lightBlue.saturation(36).lightness(88),
				fg = colours.lightBlue.saturation(60).lightness(48),
				gui = 'nocombine,italic',
			}),
			DiagnosticVirtualTextHint({
				bg = colours.lightGreen.saturation(36).lightness(88),
				fg = colours.lightGreen.saturation(60).lightness(48),
				gui = 'nocombine,italic',
			}),

			GitSignsAddSign({ SignColumn, fg = colours.lightGreen, gui = 'nocombine' }),
			GitSignsChangeSign({ SignColumn, fg = colours.lightBlue, gui = 'nocombine' }),
			GitSignsDeleteSign({ SignColumn, fg = colours.lightRed, gui = 'nocombine' }),
			GitSignsAddNr({ LineNr, fg = colours.lightGreen, gui = 'nocombine' }),
			GitSignsChangeNr({ LineNr, fg = colours.lightBlue, gui = 'nocombine' }),
			GitSignsDeleteNr({ LineNr, fg = colours.lightRed, gui = 'nocombine' }),

			CmpItemAbbr({ fg = colours.lightBlack, gui = 'nocombine' }),
			CmpItemAbbrDeprecated({ fg = colours.grey, gui = 'nocombine,strikethrough' }),
			CmpItemAbbrMatch({ fg = colours.purple, gui = 'nocombine,bold' }),
			CmpItemAbbrMatchFuzzy({ fg = colours.lightPurple, gui = 'nocombine,bold' }),
			CmpItemKind({ fg = colours.lightBlue }),
			CmpItemMenu({ Comment }),

			NotifyDEBUGBody({ Normal }),
			NotifyERRORBody({ Normal }),
			NotifyINFOBody({ Normal }),
			NotifyTRACEBody({ Normal }),
			NotifyWARNBody({ Normal }),

			NeogitDiffAddHighlight({ DiffAdd }),
			NeogitDiffDeleteHighlight({ DiffDelete }),
			NeogitDiffContextHighlight({ DiffChange }),
			NeogitHunkHeader({
				fg = colours.lightPurple,
				bg = colours.black.mix(colours.yellow, 25),
				gui = 'nocombine',
			}),
			NeogitHunkHeaderHighlight({ NeogitHunkHeader, gui = 'nocombine,underline,bold' }),
			NeotestAdapterName({ fg = colours.purple, gui = 'nocombine,bold' }),
			NeotestBorder({ fg = colours.lightPurple, gui = 'nocombine' }),
			NeotestDir({ fg = colours.yellow, gui = 'nocombine' }),
			NeotestExpandMarker({ fg = colours.black, gui = 'nocombine' }),
			NeotestFailed({ fg = colours.red, gui = 'nocombine,bold' }),
			NeotestFile({ fg = colours.green, gui = 'nocombine,italic' }),
			NeotestFocused({ bg = colours.lightWhite, gui = 'nocombine' }),
			NeotestIndent({ fg = colours.black, gui = 'nocombine' }),
			NeotestMarked({ fg = colours.orange, gui = 'nocombine,bold,underdotted' }),
			NeotestNamespace({ fg = colours.lightPurple, gui = 'nocombine' }),
			NeotestPassed({ fg = colours.lightGreen, gui = 'nocombine,bold' }),
			NeotestRunning({ fg = colours.yellow, gui = 'nocombine,underdashed' }),
			NeotestWinSelect({ fg = colours.lightBlack, gui = 'nocombine' }),
			NeotestSkipped({ fg = colours.lightOrange, gui = 'nocombine,underdotted' }),
			NeotestTarget({ fg = colours.cyan, gui = 'nocombine' }),
			NeotestTest({ fg = colours.blue, gui = 'nocombine,bold' }),
			NeotestUnknown({ fg = colours.grey, gui = 'nocombine,italic' }),
		}
	end),
})

return theme
