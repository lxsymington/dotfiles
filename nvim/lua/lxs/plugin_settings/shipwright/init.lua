local api = vim.api
local lush = require("lush")

local M = {}

M.YamlTable = {
	__tostring = function(table)
		local function yamlRecurse(tableSection, indent_level)
			local result = ""

			for key, value in pairs(tableSection) do
				-- TODO: handle list-like tables
				if type(value) == "table" then
					result = string.format(
						"%s\n%s%s:%s",
						result,
						string.rep(" ", 2 * indent_level),
						key,
						yamlRecurse(value, indent_level + 1)
					)
				else
					result = string.format("%s\n%s%s: %q", result, string.rep(" ", 2 * indent_level), key, value)
				end
			end

			return result
		end

		return yamlRecurse(table, 0)
	end,
}

function M.setup()
	lush(require(vim.g.colors_name))

	vim.cmd("Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/alacritty.lua")

	api.nvim_create_augroup("LushBuild", { clear = true })
	api.nvim_create_autocmd("BufWritePost", {
		pattern = "*/crepuscular/**",
		callback = function()
			vim.cmd("Shipwright ~/.dotfiles/nvim/lua/lxs/plugin_settings/shipwright/alacritty.lua")
		end,
	})
end

return M
