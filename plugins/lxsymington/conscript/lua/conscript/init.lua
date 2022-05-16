local filereadable = vim.fn.filereadable
local json         = vim.json
local M            = {}

--[[
 TODO:
 - watch the package.json for changes
 - expose <Plug>bindings for running the scripts
 - parse command output if useful otherwise notify of completion
]]

function M.scout()
    local is_node_project = filereadable('package.json')

    if not is_node_project then
        return
    end

    vim.notify('Enrolling conscript 💂', vim.log.levels.INFO)

    local package_json_path = vim.loop.cwd() .. '/package.json'

    M.exercises(package_json_path)
end

function M.exercises(package_json_path)
    local package_json_handle = io.open(package_json_path, 'r')
    if not package_json_handle then
        return
    end
    local package_json_contents = package_json_handle:read('*a')
    local package_json = json.decode(package_json_contents)

    if #package_json['scripts'] then
        vim.pretty_print(package_json['scripts'])
    end
end

return M
