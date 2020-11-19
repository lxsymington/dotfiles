-- GENERAL
local M = {}

function M.setup()
    -- Sets encoding to UTF-8
    vim.bo.fileencoding = 'utf-8'

    -- Do not add BOM marks
    vim.bo.bomb = false

    -- Use host system format
    vim.o.fileformats = [[unix,dos,mac]]

    -- Enables syntax highlighting
    -- syntax enable

    -- Security
    vim.o.modelines = 0

    -- Sets the backspace behaviour to conventional
    vim.o.backspace = [[indent,eol,start]]
    

    -- Change the default leader ('\') character for custom mappings
    vim.g.mapleader = ','

    -- Enables line numbers
    vim.wo.number = true
    vim.wo.relativenumber = true

    -- Force the cursor onto a new line after 120 characters
    vim.bo.textwidth = 120

    -- Creates a visual boundary
    vim.wo.colorcolumn = [[81,+1]]

    -- Displays invisibles
    vim.wo.list = true

    -- Sets characters to display for invisible characters
    vim.o.listchars = [[space:―,tab:» ,eol:␤,nbsp:⨝,extends:↩,precedes:↪]]

    -- Sets ambiguous width characters to be double width
    vim.o.ambiwidth = 'single'

    -- Hide the default mode text (e.g. -- INSERT -- below the statusline)
    vim.o.showmode = false

    -- Enable the mouse
    vim.o.mouse = 'a'

    -- Set the chord timeout length to 100ms
    vim.o.timeoutlen = 1000
    vim.o.ttimeoutlen = 100

    -- Set wrapped lines to continue visual indentation
    vim.wo.breakindent = true

    -- Set breakindent options
    vim.wo.breakindentopt = [[min:20,shift:0,sbr]]

    -- Preview effects of :s as you type
    vim.o.inccommand = 'nosplit'

    -- Hide abandoned buffers instead of unloading them
    vim.o.hidden = true

    -- Enable auto-saving
    vim.o.autowriteall = true

    -- Enable auto-reading
    vim.o.autoread = true

    -- Do not keep a backup file, use versions instead
    vim.o.backup = false
    vim.o.writebackup = false

    -- Extra line for display command messages
    vim.o.cmdheight = 1

    -- Set a shorter time before the CursorHold event is triggered
    vim.o.updatetime = 300

    -- Don't show |ins-completion-menu| messages
    vim.o.shortmess = vim.o.shortmess .. 'c'

    -- Improve mergetool and diff experience by using git's built in diff
    vim.o.diffopt = [[filler,iblank,iwhite,indent-heuristic,algorithm:patience]]

    -- Keep an undo file (undo changes after closing)
    if vim.fn.has 'persistent_undo' then
        vim.o.undofile = true
    end
end

return M
