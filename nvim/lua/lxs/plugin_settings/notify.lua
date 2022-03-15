local wk = require("which-key")
local M = {}

-- Notify ------------------------------
function M.notifications()
	local telescope_available, _ = pcall(require, "telescope")

	if telescope_available then
		local opts = require("telescope.themes").get_dropdown({
			border = true,
		})

		require("telescope").extensions.notify.notify(opts)
	else
		vim.cmd("Notifications")
	end
end

function M.setup()
	vim.notify = require("notify")

	wk.register({
		["<Leader>N"] = {
			'<Cmd>lua require("lxs.plugin_settings.notify").notifications()<CR>',
			"Notifications",
		},
	}, {
		mode = "n",
		noremap = true,
		silent = true,
	})
end

return M
