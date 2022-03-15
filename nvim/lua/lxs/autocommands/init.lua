local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd
local terminal = require("lxs.autocommands.terminal")
local M = {}

-- Autocommands Index ------------------
function M.setup()
	terminal.setup()

	local terminal_group = nvim_create_augroup("Terminal", { clear = true })
	nvim_create_autocmd(
		{ "TermOpen", "TermEnter" },
		{ pattern = "*", command = "TerminalStyle", group = terminal_group }
	)

	local highlight_yank_group = nvim_create_augroup("HighlightYank", { clear = true })
	nvim_create_autocmd("TextYankPost", {
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "IncSearch",
				timeout = 150,
			})
		end,
		group = highlight_yank_group,
	})

	local reload_config_group = nvim_create_augroup("ReloadConfig", { clear = true })
	nvim_create_autocmd("BufWritePost", {
		pattern = { "*/nvim/**" },
		command = "ReloadConfig",
		once = true,
		group = reload_config_group,
	})
end

return M
