local M = {}

-- LIGHTBULB ---------------------------
function M.setup()
    vim.cmd [[
        augroup LightBulb
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
        augroup END
    ]]
end

return M
