"======= Startify ============================================================="
"Automatically update sessions
let g:startify_session_persistence = 1

"Sort sessions by modification time
let g:startify_session_sort = 1

"The number of spaces used for left padding.
let g:startify_padding_left = 5

"Custom header
let g:startify_custom_header = [
    \ '     ██╗   ██╗██╗███╗   ███╗     ',
    \ '     ██║   ██║██║████╗ ████║     ',
    \ '     ██║   ██║██║██╔████╔██║     ',
    \ '     ╚██╗ ██╔╝██║██║╚██╔╝██║     ',
    \ '      ╚████╔╝ ██║██║ ╚═╝ ██║     ',
    \ '       ╚═══╝  ╚═╝╚═╝     ╚═╝     ',
    \ ]

"Start lists
let g:startify_lists = [
    \ {'type': 'sessions', 'header': ['Sessions']},
    \ {'type': 'dir', 'header': ['MRU ' . getcwd()]},
    \ {'type': 'files', 'header': ['MRU']},
    \ {'type': 'commands', 'header': ['Commands']}
    \ ]
