local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd
local terminal = require('lxs.autocommands.terminal')
local M = {}

local augroup_store = {}

M.session_augroups = setmetatable(augroup_store, {
    __call = function(self, group_name, opts)
        local final_opts = opts or { clear = true }
        local group = nvim_create_augroup(group_name, final_opts)
        table.insert(self, group)
        return group
    end
})

-- Autocommands Index ------------------
function M.setup()
    terminal.setup()

    local terminal_group = M.session_augroups('Terminal')
    nvim_create_autocmd(
        { 'TermOpen', 'TermEnter' },
        { pattern = '*', command = 'TerminalStyle', group = terminal_group }
    )

    local highlight_yank_group = M.session_augroups('HighlightYank')
    nvim_create_autocmd('TextYankPost', {
        pattern = '*',
        callback = function()
            vim.highlight.on_yank({
                higroup = 'IncSearch',
                timeout = 150,
            })
        end,
        group = highlight_yank_group,
    })

    local reload_config_group = M.session_augroups('ReloadConfig')
    nvim_create_autocmd('BufWritePost', {
        pattern = { '*/nvim/**' },
        command = 'ReloadConfig',
        once = true,
        group = reload_config_group,
    })
end

return M
