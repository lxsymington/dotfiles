local Theme = require('lxs.utils').Theme
local colours = require(vim.g.colors_name .. '.colours')
local kitty = require('lxs.plugin_settings.shipwright.kitty')
local alacritty = require('lxs.plugin_settings.shipwright.alacritty')

run(
    colours,
    Theme.new,
    {branch,
        kitty,
        {
            overwrite,
            os.getenv('HOME') .. '/.dotfiles/kitty/themes/' .. vim.g.colors_name .. '.conf',
        }
    },
    {branch,
        alacritty,
        {
            overwrite,
            os.getenv('HOME') .. '/.dotfiles/alacritty/alacritty.colours.yml',
        }
    }
)
