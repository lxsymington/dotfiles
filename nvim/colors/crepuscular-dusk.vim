let g:colors_name="crepuscular-dusk"

set background=dark
lua package.loaded['lush_theme.crepuscular-dusk'] = nil
lua require('lush')(require('lush_theme.crepuscular-dusk'))
