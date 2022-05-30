local lush = require('lush')

package.loaded['crepuscular.colours'] = nil
local colours = require('crepuscular.colours')

-- CREPUSCULAR -------------------------

local theme = lush(function()
	return {
		Black({ fg = colours.black }),
		BlackItalic({ Black, gui = 'nocombine,italic' }),
		BlackBG({ bg = colours.black }),
		Blue({ fg = colours.blue }),
		BlueItalic({ Blue, gui = 'nocombine,italic' }),
		BlueBG({ bg = colours.blue }),
		Cyan({ fg = colours.cyan }),
		CyanItalic({ Cyan, gui = 'nocombine,italic' }),
		CyanBG({ bg = colours.cyan }),
		Green({ fg = colours.green }),
		GreenItalic({ Green, gui = 'nocombine,italic' }),
		GreenBG({ bg = colours.green }),
		Grey({ fg = colours.grey }),
		GreyItalic({ Grey, gui = 'nocombine,italic' }),
		GreyBG({ bg = colours.grey }),
		Orange({ fg = colours.orange }),
		OrangeItalic({ Orange, gui = 'nocombine,italic' }),
		OrangeBG({ bg = colours.orange }),
		Purple({ fg = colours.purple }),
		PurpleItalic({ Purple, gui = 'nocombine,italic' }),
		PurpleBG({ bg = colours.purple }),
		Red({ fg = colours.red }),
		RedItalic({ Red, gui = 'nocombine,italic' }),
		RedBG({ bg = colours.red }),
		White({ fg = colours.white }),
		WhiteItalic({ White, gui = 'nocombine,italic' }),
		WhiteBG({ bg = colours.white }),
		Yellow({ fg = colours.yellow }),
		YellowItalic({ Yellow, gui = 'nocombine,italic' }),
		YellowBG({ bg = colours.yellow }),

		LightBlack({ fg = colours.lightBlack }),
		LightBlackItalic({ LightBlack, gui = 'nocombine,italic' }),
		LightBlackBG({ bg = colours.lightBlack }),
		LightBlue({ fg = colours.lightBlue }),
		LightBlueItalic({ LightBlue, gui = 'nocombine,italic' }),
		LightBlueBG({ bg = colours.lightBlue }),
		LightCyan({ fg = colours.lightCyan }),
		LightCyanItalic({ LightCyan, gui = 'nocombine,italic' }),
		LightCyanBG({ bg = colours.lightCyan }),
		LightGreen({ fg = colours.lightGreen }),
		LightGreenItalic({ LightGreen, gui = 'nocombine,italic' }),
		LightGreenBG({ bg = colours.lightGreen }),
		LightGrey({ fg = colours.lightGrey }),
		LightGreyItalic({ LightGrey, gui = 'nocombine,italic' }),
		LightGreyBG({ bg = colours.lightGrey }),
		LightOrange({ fg = colours.lightOrange }),
		LightOrangeItalic({ LightOrange, gui = 'nocombine,italic' }),
		LightOrangeBG({ bg = colours.lightOrange }),
		LightPurple({ fg = colours.lightPurple }),
		LightPurpleItalic({ LightPurple, gui = 'nocombine,italic' }),
		LightPurpleBG({ bg = colours.lightPurple }),
		LightRed({ fg = colours.lightRed }),
		LightRedItalic({ LightRed, gui = 'nocombine,italic' }),
		LightRedBG({ bg = colours.lightRed }),
		LightWhite({ fg = colours.lightWhite }),
		LightWhiteItalic({ LightWhite, gui = 'nocombine,italic' }),
		LightWhiteBG({ bg = colours.lightWhite }),
		LightYellow({ fg = colours.lightYellow }),
		LightYellowItalic({ LightYellow, gui = 'nocombine,italic' }),
		LightYellowBG({ bg = colours.lightYellow }),
		Ignore({}),

		Error({ bg = colours.red, fg = colours.lightWhite, gui = 'nocombine,bold,italic' }),
		Todo({ bg = colours.blue, fg = colours.lightWhite, gui = 'nocombine,bold,italic' }),
		ErrorMsg({
			bg = colours.lightWhite,
			fg = colours.red,
			gui = 'nocombine,bold,italic,undercurl',
			sp = colours.red,
		}),
		WarningMsg({
			bg = colours.yellow,
			fg = colours.black.darken(40),
			gui = 'nocombine,bold,italic,undercurl',
			sp = colours.black.darken(40),
		}),
		Bold({ gui = 'nocombine,bold' }),
		Italic({ gui = 'nocombine,italic' }),
		Debug({ fg = colours.orange, gui = 'nocombine,bold' }),
		Delimiter({ fg = colours.lightGreen, gui = 'nocombine,bold' }),
		Special({ fg = colours.lightPurple, gui = 'nocombine,bold' }),
		SpecialChar({ fg = colours.purple, gui = 'nocombine' }),
		Underlined({ gui = 'nocombine,underline' }),

		Conceal({ bg = colours.grey, fg = colours.lightGrey, gui = 'nocombine' }),
		Cursor({ gui = 'nocombine,reverse' }),
		CursorIM({ gui = 'nocombine,reverse' }),
		Directory({ fg = colours.lightBlue, gui = 'nocombine,bold' }),
		EndOfBuffer({ fg = colours.lightGrey, gui = 'nocombine' }),
		FoldColumn({ fg = colours.lightGrey, gui = 'nocombine' }),
		Folded({ fg = colours.lightPurple.desaturate(50), gui = 'nocombine,bold,italic' }),
		PmenuThumb({ bg = colours.lightYellow, fg = colours.blue, gui = 'nocombine' }),
		Question({ fg = colours.lightOrange, gui = 'nocombine' }),
		Search({ bg = colours.green, fg = colours.white, gui = 'nocombine,bold,italic' }),
		SpecialKey({ fg = colours.purple, gui = 'nocombine' }),
		Title({ fg = colours.orange, gui = 'nocombine' }),
		lCursor({ gui = 'nocombine,reverse,bold' }),

		Boolean({ fg = colours.yellow, gui = 'nocombine' }),
		Character({ fg = colours.lightGreen, gui = 'nocombine' }),
		Conditional({ fg = colours.orange, gui = 'nocombine' }),
		Define({ fg = colours.purple, gui = 'nocombine' }),
		Exception({ fg = colours.red, gui = 'nocombine,bold,undercurl' }),
		Number({ fg = colours.lightRed, gui = 'nocombine' }),
		Float({ Number }),
		Identifier({ fg = colours.lightYellow, gui = 'nocombine' }),
		Include({ fg = colours.blue, gui = 'nocombine' }),
		Keyword({ fg = colours.blue, gui = 'nocombine' }),
		Label({ fg = colours.red, gui = 'nocombine' }),
		Macro({ Define }),
		Operator({ fg = colours.lightOrange, gui = 'nocombine' }),
		PreProc({ fg = colours.lightOrange, gui = 'nocombine' }),
		Repeat({ fg = colours.lightPurple, gui = 'nocombine' }),
		Statement({ fg = colours.green, gui = 'nocombine' }),

		TSAnnotation({ Special }),
		TSBoolean({ Boolean }),
		TSCharacter({ Character }),
		TSConditional({ Conditional }),
		TSConstBuiltin({ fg = colours.cyan, gui = 'nocombine,bold' }),
		TSConstMacro({ fg = colours.blue, gui = 'nocombine,bold' }),
		TSEmphasis({ gui = 'nocombine,italic' }),
		TSError({ ErrorMsg }),
		TSException({ Exception }),
		TSFloat({ Float }),
		TSFuncBuiltin({ Special }),
		TSFuncMacro({ Macro }),
		TSInclude({ Include }),
		TSKeyword({ Keyword }),
		TSLabel({ Label }),
		TSNamespace({ Identifier }),
		TSNumber({ Number }),
		TSOperator({ Operator }),
		TSPunctDelimiter({ Delimiter }),
		TSPunctSpecial({ Special }),
		TSRepeat({ Repeat }),
		TSStringEscape({ fg = colours.lightOrange, gui = 'nocombine' }),
		TSStringRegex({ fg = colours.cyan, gui = 'nocombine' }),
		TSStrong({ gui = 'nocombine,bold' }),
		TSTitle({ Title }),
		TSURI({ gui = 'underline', sp = colours.lightBlue }),
		TSUnderline({ gui = 'nocombine,underline' }),
		TSVariable({ fg = colours.green, gui = 'nocombine' }),
		TSVariableBuiltin({ fg = colours.purple, gui = 'nocombine,bold' }),

		DiagnosticError({ fg = colours.red, gui = 'nocombine' }),
		DiagnosticHint({ fg = colours.lightGreen, gui = 'nocombine' }),
		DiagnosticInfo({ fg = colours.lightBlue, gui = 'nocombine' }),
		DiagnosticWarn({ fg = colours.yellow, gui = 'nocombine' }),
		DiagnosticFloatingError({
			DiagnosticError,
			fg = DiagnosticError.fg.saturation(60).lightness(60),
		}),
		DiagnosticFloatingHint({
			DiagnosticHint,
			fg = DiagnosticHint.fg.saturation(60).lightness(60),
		}),
		DiagnosticFloatingInfo({
			DiagnosticInfo,
			fg = DiagnosticInfo.fg.saturation(60).lightness(60),
		}),
		DiagnosticFloatingWarn({
			DiagnosticWarn,
			fg = DiagnosticWarn.fg.saturation(60).lightness(60),
		}),
		DiagnosticSignError({ DiagnosticError, gui = 'nocombine,bold' }),
		DiagnosticSignHint({ DiagnosticHint, gui = 'nocombine,bold' }),
		DiagnosticSignInfo({ DiagnosticInfo, gui = 'nocombine,bold' }),
		DiagnosticSignWarn({ DiagnosticWarn, gui = 'nocombine,bold' }),
		DiagnosticUnderlineError({ gui = 'nocombine,undercurl', sp = colours.red }),
		DiagnosticUnderlineHint({ gui = 'nocombine,undercurl', sp = colours.lightGreen }),
		DiagnosticUnderlineInfo({ gui = 'nocombine,undercurl', sp = colours.lightBlue }),
		DiagnosticUnderlineWarn({ gui = 'nocombine,undercurl', sp = colours.yellow }),
		LspReferenceRead({ fg = colours.lightGrey, gui = 'nocombine,italic' }),
		LspReferenceText({ fg = colours.lightPurple, gui = 'nocombine,italic' }),
		LspReferenceWrite({ fg = colours.purple, gui = 'nocombine,italic' }),
        NotifyDEBUGBorder({ fg = colours.purple, gui = 'nocombine' }),
        NotifyDEBUGIcon({ fg = colours.purple, gui = 'nocombine' }),
        NotifyDEBUGTitle({ fg = colours.purple, gui = 'nocombine,bold' }),
        NotifyERRORBorder({ fg = colours.red, gui = 'nocombine' }),
        NotifyERRORIcon({ fg = colours.red, gui = 'nocombine' }),
        NotifyERRORTitle({ fg = colours.red, gui = 'nocombine,bold' }),
        NotifyINFOBorder({ fg = colours.blue, gui = 'nocombine' }),
        NotifyINFOIcon({ fg = colours.blue, gui = 'nocombine' }),
        NotifyINFOTitle({ fg = colours.blue, gui = 'nocombine,bold' }),
        NotifyTRACEBorder({ fg = colours.green, gui = 'nocombine' }),
        NotifyTRACEIcon({ fg = colours.green, gui = 'nocombine' }),
        NotifyTRACETitle({ fg = colours.green, gui = 'nocombine,bold' }),
        NotifyWARNBorder({ fg = colours.yellow, gui = 'nocombine' }),
        NotifyWARNIcon({ fg = colours.yellow, gui = 'nocombine' }),
        NotifyWARNTitle({ fg = colours.yellow, gui = 'nocombine,bold' }),
	}
end)

return theme
