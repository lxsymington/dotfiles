let g:colors_name="crepuscular_dawn"

set background=light
lua package.loaded['lush_theme.crepuscular_dawn'] = nil
lua require('lush')(require('lush_theme.crepuscular_dawn'))
