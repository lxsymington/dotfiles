local lush = require('lush')
local hsl = lush.hsl

-- AFTERGLOW ---------------------------

-- Colours
local black = hsl(275, 20, 10) -- original "#111224"
local blue = hsl(250, 60, 45) -- original "#155199"
-- local cyan = "#6187ae"
-- local green = "#354e39"
-- local grey = "#786674"
-- local orange = "#ec722f"
-- local purple = "#673a5b"
-- local red = "#a95062"
-- local white = "#ebd3b9"
-- local yellow = "#ffc346"

-- local lightBlack = "#222035"
-- local lightBlue = "#356ea5"
-- local lightCyan = "#83a0c8"
-- local lightGray = "#9f8d9d"
-- local lightGreen = "#5e723f"
-- local lightGrey = "#9f8d9d"
-- local lightOrange = "#fe882e"
-- local lightPurple = "#9f7195"
-- local lightRed = "#c5696e"
-- local lightWhite = "#fcf9f0"
-- local lightYellow = "#ffd782"

-- BG        cterm=reverse gui=reverse
-- Bold      cterm=bold gui=bold
-- Italic    cterm=italic gui=italic

-- Theme
local theme = lush(function()
  return {
    Normal { fg = hsl(54, 27, 86), bg = black },
    CursorLine { bg = black.darken(20) },
    CursorColumn { bg = black.darken(10) },
    LineNr       { bg = black.lighten(5), fg = black.lighten(20) },
    CursorLineNr { bg = black, fg = Normal.fg.ro(180) },
    Visual { bg = blue, fg = Normal.fg.rotate(180) },
  }
end)

return theme
