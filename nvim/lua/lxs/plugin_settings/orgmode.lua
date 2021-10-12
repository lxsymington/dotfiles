local orgmode = require('orgmode')
local headlines = require('headlines')
local bullets = require('org-bullets')
local M = {}

-- Orgmode -----------------------------
function M.setup()
    orgmode.setup({
        org_agenda_files = { '~/Documents/org_agenda' },
        org_default_notes_files = { '~/Documents/org_notes' },
    })

    headlines.setup()
    bullets.setup()
end

return M
