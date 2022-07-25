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

    M.cache = vim.tbl_extend('force', M.cache, package_json.scripts)
end

function M.exercises(cmd)
    local script_names = vim.tbl_keys(M.cache)
    local bufnr = vim.api.nvim_get_current_buf()

    if #cmd.args < 1 then
        vim.ui.select(script_names, {
            prompt = 'Select a script to run',
            format_item = function(item)
                return string.format('%s | %s', item, M.cache[item])
            end,
        }, function(selection, item_index)
            M.drill(selection, bufnr)
        end)
    elseif vim.tbl_contains(vim.tbl_keys(M.cache), cmd.args) then
        M.drill(cmd.args, bufnr)
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

function M.drill(script, bufnr)
    vim.notify(
        string.format('Running npm script: %s', script),
        vim.log.levels.INFO
    )

    local efm = vim.api.nvim_buf_get_option(bufnr, 'errorformat')

    local job = Job:new({
        command = 'npm',
        args = { 'run', script },
        cwd = vim.loop.cwd(),
    })

    job:start()
    job:wait(300000, 500)
    job:after(function()
        job:shutdown()
    end)
    local result = job:result()
    local stderr = job:stderr_result()
    if #stderr then
        vim.fn.setqflist({}, ' ', {
            title = string.format('npm run', script),
            lines = stderr,
            efm = efm
        })
        vim.api.nvim_exec_autocmds('QuickFixCmdPost', {
            buffer = bufnr,
        })
    end
    vim.pretty_print("stderr", stderr, "results", result)
end

return M
