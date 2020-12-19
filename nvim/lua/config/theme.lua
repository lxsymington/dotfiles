local M = {}

-- THEME -------------------------------
function M.setup()
    -- Set terminal to use true color
    if vim.fn.exists('+termguicolors') then vim.o.termguicolors = true end

    vim.o.guicursor =
        [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]

    -- Sets the background to be dark
    vim.o.background = 'dark'

    -- Sets the colorscheme to be Seoul 256 Light
    -- colorscheme seoul256-light

    -- Sets the colorscheme to be Seoul 256
    -- colorscheme seoul256

    -- Sets the colorscheme to be Night Owl
    -- colorscheme night-owl

    -- Enable background transparency
    -- hi! Normal ctermbg=NONE guibg=NONE
    -- hi! NonText ctermbg=NONE guibg=NONE
    -- hi! EndOfBuffer ctermbg=NONE guibg=NONE
    -- hi! SignColumn ctermbg=NONE guibg=NONE

    -- Miramare configuration
    -- let g:miramare_transparent_background = 1
    -- vim.g.miramare_enable_italic = 1
    -- vim.g.miramare_enable_bold = 1

    -- Sets the colorscheme to be Miramare
    -- vim.g.colors_name = 'miramare'

    -- Sets the colorscheme to be Afterglow
    vim.g.colors_name = 'crepuscular'
end

return M
