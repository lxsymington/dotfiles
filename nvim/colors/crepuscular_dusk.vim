let g:colors_name="crepuscular_dusk"

set background=dark
lua package.loaded['lush_theme.crepuscular_dusk'] = nil
lua require('lush')(require('lush_theme.crepuscular_dusk'))
