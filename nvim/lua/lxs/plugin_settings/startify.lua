local M = {}

-- Startify ----------------------------
function M.setup()
	-- Automatically update sessions
	vim.g.startify_session_persistence = 1

	-- Sort sessions alphabetically rather than by modification time
	vim.g.startify_session_sort = 0

	-- Set the session directory
	vim.g.startify_session_dir = '~/.local/share/nvim/sessions'

	-- Custom header
	vim.g.startify_custom_header = {
		'   ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗   ',
		'   ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║   ',
		'   ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║   ',
		'   ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║   ',
		'   ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║   ',
		'   ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝   ',
	}

	-- Start lists
	vim.g.startify_lists = {
		{ type = 'sessions', header = { '   Sessions' } },
		{ type = 'dir', header = { '   MRU ' .. vim.fn.getcwd() } },
		{ type = 'files', header = { '   MRU' } },
		{ type = 'commands', header = { '   Commands' } },
	}

	-- Close LuaTree
	vim.g.startify_session_before_save = {
		'echo "Cleaning up before saving.."',
		'OverseerClose',
	}
end

return M
