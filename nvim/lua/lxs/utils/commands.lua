local session_augroups = require('lxs.autocommands').session_augroups
local opt = vim.opt
local api = vim.api
local M = {}

function M.reloadConfig()
    vim.notify('Reloading Neovim configuration…', 'info')
    for name, _ in pairs(package.loaded) do
        if name:match('^lxs') or name:match('^' .. vim.g.colors_name) then
            package.loaded[name] = nil
        end
    end

    for _, group in ipairs(session_augroups) do
        vim.api.nvim_clear_autocmds({ group = group })
    end

    local vimrc_ok, vimrc_ret = pcall(dofile, vim.env.MYVIMRC)
    if not vimrc_ok then
        vim.notify(vimrc_ret, 'error')
    end
    vim.cmd('PackerCompile')
    vim.notify('Packer Recompiled', 'info')

    -- Fix feline highlights
    local ok, feline = pcall(require, 'feline')
    if ok then
        feline.reset_highlights()
    end
    vim.notify('Neovim configuration reload complete', 'info')
end

function M.numberToggle()
    opt.number = true

    local current_value = api.nvim_win_get_option(api.nvim_get_current_win(), 'relativenumber')

    if current_value then
        opt.relativenumber = false
    else
        opt.relativenumber = true
    end
end

function M.setup()
    -- Toggle betwen normal and relative line numbers
    api.nvim_create_user_command('NumberToggle', require('lxs.utils.commands').numberToggle, {})

    -- Save and execute the current file
    api.nvim_create_user_command('ReloadConfig', require('lxs.utils.commands').reloadConfig, {})
end

return M
