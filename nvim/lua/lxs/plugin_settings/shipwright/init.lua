local session_augroups = require('lxs.autocommands').session_augroups
local api = vim.api
local lush = require('lush')

local M = {}

function M.shipwright_build(should_set_colourscheme)
    if should_set_colourscheme then
        lush(require(vim.g.colors_name))
    end

    vim.cmd('Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/build.lua')
end

function M.setup()
    lush(require(vim.g.colors_name))

    api.nvim_create_user_command('ApplyColourscheme', function()
        M.shipwright_build(true)
    end, {})

    local shipwright_group = session_augroups('Shipwright')
    api.nvim_create_autocmd('VimEnter', {
        callback = function()
            M.shipwright_build(false)
        end,
        group = shipwright_group,
    })
    api.nvim_create_autocmd('BufWritePost', {
        pattern = string.format('*/%s/**', vim.g.colors_name),
        callback = function()
            M.shipwright_build(true)
        end,
        group = shipwright_group,
    })
end

return M
