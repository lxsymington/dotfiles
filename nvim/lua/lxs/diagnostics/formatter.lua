local lsp_loaded, util = pcall(require, 'lspconfig.util')
local formatter = require('formatter')
local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local M = {}

local function select_config_file(config_files)
    for _, config_file in ipairs(config_files) do
        local fullPath = util.path.join(vim.loop.cwd, config_file)

        if vim.fn.filereadable(config_file) then
            return fullPath
        end
    end
end

function M.prettier()
    if not vim.loop.os_getenv('PRETTIERD_LOCAL_PRETTIER_ONLY') then
        vim.loop.os_setenv('PRETTIERD_LOCAL_PRETTIER_ONLY', true)
    end

    local config_files = {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.json5',
        '.prettierrc.yml',
        '.prettierrc.yaml',
        '.prettierrc.js',
        '.prettierrc.cjs',
        '.prettierrc.config.js',
        '.prettierrc.config.cjs',
        '.prettierrc.toml',
    }

    local config = select_config_file(config_files)

    if not (lsp_loaded and config) then
        return nil
    end

    vim.loop.os_setenv('PRETTIERD_DEFAULT_CONFIG', config)

    return {
        exe = 'prettierd',
        args = { vim.api.nvim_buf_get_name(0) },
        stdin = true,
    }
end

function M.tslint()
    if not vim.fn.filereadable("tslint.json") then
        return nil
    end

    return {
        exe = "tslint",
        args = { "-c", "tslint.json", "--fix", "--force" },
        try_node_modules = true,
    }
end

function M.stylua()
    local config = vim.fn.findfile('stylua.toml', vim.loop.cwd() .. '/**')
    local config_path = vim.fn.fnamemodify(config, ':p:.')

    return {
        exe = 'stylua',
        args = {
            '--config-path ' .. config_path,
            '-',
        },
        stdin = true,
    }
end

function M.setup()
    formatter.setup({
        filetype = {
            javascript = {
                M.prettier,
            },
            json = {
                M.prettier,
            },
            lua = {
                M.stylua,
            },
        },
    })

    local format_group = augrp('Format', { clear = true })
    aucmd('BufWritePost', {
        pattern = { '*.js', '*.cjs', '*.mjs', '*.jsx', '*.ts', '*.tsx', '*.lua' },
        command = 'FormatWrite',
        once = true,
        group = format_group,
    })
end

return M
