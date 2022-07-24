local Job = require('plenary.job')
local expand = vim.fn.expand
local filereadable = vim.fn.filereadable
local json = vim.json
local M = {}

--[[
 TODO:
 - watch the package.json for changes
 - expose <Plug>bindings for running the scripts
 - parse command output if useful otherwise notify of completion
]]

M.regiments = {
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
    '*.yml',
}

--  TODO: make it so that this only stores one set of scripts and can be easily cleared
M.cache = {}

--[[
 TODO:
 - locate a package.json in the `pwd` or ancestors
    - check if there is some better way of doing this via the LSP
 - parse the package.json to find any `scripts`
 - if there are scripts load the rest of the plugin
]]
function M.scout()
    local conscript_augroup = vim.api.nvim_create_augroup('ConscriptScout', { clear = true })

    local expected_path = expand(vim.loop.cwd() .. '/package.json')
    local is_node_project = filereadable(expected_path) == 1

    if not is_node_project then
        vim.api.nvim_clear_autocmds({ group = conscript_augroup })
        return
    end

    vim.notify('Node project detected, Enrolling conscript 💂', vim.log.levels.INFO)

    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = M.regiments,
        callback = M.patrol,
        group = conscript_augroup,
        once = true
    })

    local package_json_path = vim.loop.cwd() .. '/package.json'

    local package_json_handle = io.open(package_json_path, 'r')

    if not package_json_handle then
        return
    end

    local package_json_contents = package_json_handle:read('*a')
    package_json_handle:close()
    local package_json = json.decode(package_json_contents)

    if not #package_json.scripts then
        vim.notify('No scripts found', vim.log.levels.INFO)
        return
    end

    -- TODO: improve this
    M.cache = vim.tbl_extend('force', M.cache, package_json.scripts)
end

function M.exercises(cmd)
    local script_names = vim.tbl_keys(M.cache)

    if #cmd.args < 1 then
        vim.ui.select(script_names, {
            prompt = 'Select a script to run',
            format_item = function(item)
                return string.format('%s | %s', item, M.cache[item])
            end,
        }, M.drill)
    elseif vim.tbl_contains(vim.tbl_keys(M.cache), cmd.args) then
        M.drill(cmd.args)
    else
        vim.notify(
            string.format('script: %s does not match any found in package.json', cmd.args),
            vim.log.levels.ERROR
        )
    end
end

function M.patrol(event)
    vim.api.nvim_buf_create_user_command(event.buf, 'Make', M.exercises, {
        complete = function()
            return vim.tbl_keys(M.cache)
        end,
        desc = 'Asynchronous make',
        nargs = '*'
    })
end

function M.drill(script, idx)
    vim.notify(
        string.format('Running npm script: %s', script),
        vim.log.levels.INFO
    )
    local job = Job:new({
        command = 'npm',
        args = { 'run', script },
        cwd = vim.loop.cwd(),
    })

    job:start()
    job:after_failure(function(...)
        vim.pretty_print('failure', ...)
        local stderr = job:stderr_result()
        local result = job:result()
        vim.pretty_print("results", stderr, result)
        job:shutdown()
    end)
    job:after_success(function(...)
        vim.pretty_print('success', ...)
        local results = job:result()
        vim.pretty_print("results", results)
        job:shutdown()
    end)
end

return M
