local snippets = reuire('snippets')
local M = {}

-- SNIPPETS ----------------------------
function M.setup()
    snippets.use_suggested_mappings()

    vimp.inoremap({'silent'}, '<c-k>', function() snippets.expand_or_advance(1) end)
    vimp.inoremap({'silent'}, '<c-j>', function() snippets.advance_snippet(-1) end)

    snippets.snippets = {}
end

return M
