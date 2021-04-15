-- Config Index ------------------------
function config()
    require('lxs.config.utils').setup()
    require('lxs.config.environment').setup()
    require('lxs.config.external').setup()
    require('lxs.config.base').setup()
    require('lxs.config.mappings').setup()
    require('lxs.config.ui').setup()
    require('lxs.config.theme').setup()
end

return config()
