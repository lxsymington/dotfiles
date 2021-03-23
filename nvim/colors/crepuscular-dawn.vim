let g:colors_name="crepuscular-dawn"

set background=light
lua package.loaded['lush_theme.crepuscular-dawn'] = nil
lua require('lush')(require('lush_theme.crepuscular-dawn'))
