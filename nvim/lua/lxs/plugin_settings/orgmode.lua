local orgmode = require('orgmode')
local colours = require(vim.g.colors_name .. '.colours')
local M = {}

-- Orgmode -----------------------------
function M.setup()
	orgmode.setup_ts_grammar()

	orgmode.setup({
		org_agenda_files = { '~/.dotfiles/org/org_agenda', '~/Documents/Org/Agenda' },
		org_default_notes_files = { '~/.dotfiles/org/org_notes', '~/Documents/Org/Notes' },
		org_todo_keywords = {
			'PLANNING(p)',
			'TODO',
			'BLOCKED',
			'ACTIVE',
			'|',
			'CLOSED',
			'DONE',
			'TRANSFERRED',
		},
		org_todo_keyword_faces = {
			PLANNING = string.format(
				':background %s :foreground %s :weight bold',
				colours.lightBlue.hex,
				colours.black.hex
			),
			TODO = string.format(
				':background %s :foreground %s :weight bold',
				colours.blue.hex,
				colours.lightWhite.hex
			),
			BLOCKED = string.format(
				':background %s :foreground %s :weight bold :underline on',
				colours.yellow.hex,
				colours.black.hex
			),
			ACTIVE = string.format(
				':background %s :foreground %s :weight bold',
				colours.lightGreen.hex,
				colours.black.hex
			),
			CLOSED = string.format(
				':background %s :foreground %s :weight bold :underline on',
				colours.red.hex,
				colours.white.hex
			),
			DONE = string.format(
				':background %s :foreground %s :weight bold',
				colours.green.hex,
				colours.white.hex
			),
			TRANSFERRED = string.format(
				':background %s :foreground %s :slant italic:weight bold',
				colours.lightOrange.hex,
				colours.black.hex
			),
		},
	})
end

return M
