local M = {}

-- Config Index ------------------------
function M.setup()
    require('config.utils').setup()
    require('config.environment').setup()
    require('config.mappings').setup()
    require('config.base').setup()
    require('config.ui').setup()
    require('config.theme').setup()
end

return M
