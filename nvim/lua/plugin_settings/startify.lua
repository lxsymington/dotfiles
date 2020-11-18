local M = {}

-- Startify ----------------------------
function M.setup()
    -- Automatically update sessions
    vim.g.startify_session_persistence = 1

    -- Sort sessions by modification time
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
end

return M
