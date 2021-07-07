local keymap = vim.api.nvim_set_keymap

local should_reload = true
local reloader = function()
	if should_reload then
		RELOAD("plenary")
		RELOAD("popup")
		RELOAD("telescope")
	end
end

reloader()

local telescope = require("telescope")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")

local M = {}

-- TELESCOPE ---------------------------
function M.setup()
	telescope.load_extension("frecency")
	telescope.load_extension("fzy_native")

	telescope.setup({
		defaults = {
			-- for the top/right/bottom/left border.  Optionally
			-- followed by the character to use for the
			-- topleft/topright/botright/botleft corner.
			layout_strategy = "flex",
			prompt_prefix = "🔭 ➜ ",
			scroll_strategy = "cycle",
			winblend = 10,
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
		},
		extensions = {
			frecency = {
				show_scores = false,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/node_modules/*", "*/tmp/*" },
				workspaces = {
					["conf"] = os.getenv("HOME") .. "/.config",
					["data"] = os.getenv("HOME") .. "/.local/share",
					["development"] = os.getenv("HOME") .. "/Development",
					["learning"] = os.getenv("HOME") .. "/Learning",
				},
			},
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
		},
	})

	keymap("n", "<Leader><Tab>", "<Cmd>:Telescope file_browser<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader><space>", "<Cmd>:Telescope lsp_code_actions<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>?", "<Cmd>:Telescope lsp_range_code_actions<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>fb", "<Cmd>:Telescope buffers<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>fd", "<Cmd>:Telescope fd<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>ff", "<Cmd>:Telescope frecency<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>fgf", "<Cmd>:Telescope git_files<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>fht", "<Cmd>:Telescope help_tags<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>fpf", "<Cmd>:Telescope project_search<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>gb", "<Cmd>:Telescope git_branches<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>gs", "<Cmd>:Telescope git_status<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>lbg", "<Cmd>:Telescope curbuf<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>lg", "<Cmd>:Telescope live_grep<CR>", { noremap = true, silent = true })
	keymap("n", "<Leader>sr", "<Cmd>:Telescope lsp_references<CR>", { noremap = true, silent = true })
end

function M.project_search()
	builtin.find_files({
		previewer = false,
		layout_strategy = "vertical",
		cwd = require("nvim_lsp.util").root_pattern(".git")(vim.fn.expand("%:p")),
	})
end

function M.curbuf()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})

	builtin.current_buffer_fuzzy_find(opts)
end

function M.frecency()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		shorten_path = false,
	})

	telescope.extensions.frecency.frecency(opts)
end

return setmetatable({}, {
	__index = function(_, k)
		reloader()

		if M[k] then
			return M[k]
		else
			return builtin[k]
		end
	end,
})
