local findfile = vim.fn.findfile
local expand  = vim.fn.expand
local conscript = require('conscript')
local M = {}

--[[
 TODO:
 - locate a package.json in the `pwd` or ancestors
    - check if there is some better way of doing this via the LSP
 - parse the package.json to find any `scripts`
 - if there are scripts load the rest of the plugin
]]

function M.enroll()
    local conscript_augroup = vim.api.nvim_create_augroup('ConscriptEnroll', { clear = true })

    vim.api.nvim_create_autocmd(
        { 'VimEnter', 'SessionLoadPost', 'DirChanged' },
        {
            pattern = {
                '*.ts',
                '*.cts',
                '*.mts',
                '*.tsx',
                '*.js',
                '*.cjs',
                '*.mjs',
                '*.jsx',
                '*.json',
                '*.json5',
                '*.yaml',
                '*.yml'
            },
            callback = M.scout,
            group = conscript_augroup
        }
    )
end

function M.scout()
    local package_json_path = findfile('package.json',  '.;' .. vim.fn.getcwd())

    if package_json_path == '' then
        vim.ui.select(
        { 'Yes', 'No' },
        { prompt = 'No `package.json` found within the current working directory, continue up the tree?' },
            function()
                package_json_path = findfile('package.json', expand('~/Development/secclint/src/adapters') .. ';')
            end
        )
    end

    if not package_json_path == '' then
        M.guard_duty(package_json_path)
        conscript.exercises(package_json_path)
    end
end

function M.guard_duty(package_json_path)
    print('implement me')
end

M.enroll()

return M
