local M = {}

-- LIGHTBULB ---------------------------
function M.setup()
    vim.cmd [[
        augroup LightBulb
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({
            sign = {
                enabled = false,
                priority = 10,
            },
            float = {
                enabled = true,
                text = '💡',
                win_opts = { offset_x = 40 },
            }
        })
        augroup END
    ]]
end

return M
