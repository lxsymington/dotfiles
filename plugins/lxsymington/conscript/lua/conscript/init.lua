local json = vim.json
local M = {}

--[[
 TODO:
 - watch the package.json for changes
 - expose <Plug>bindings for running the scripts
 - parse command output if useful otherwise notify of completion
]]

function M.exercises(package_json_path)
    local package_json_handle = io.open(package_json_path, 'r')
    local package_json_contents = package_json_handle:read('*a')
    local package_json = json.decode(package_json_contents)

    if (#package_json['scripts']) then
        P(package_json['scripts'])
    end
end

return M
