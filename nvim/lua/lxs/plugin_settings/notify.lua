local wk = require('which-key')
local M = {}

-- Notify ------------------------------
function M.notifications()
	local telescope_available, _ = pcall(require, 'telescope')

	if telescope_available then
		local opts = require('telescope.themes').get_dropdown({
			border = true,
		})

		require('telescope').extensions.notify.notify(opts)
	else
		vim.cmd('Notifications')
	end
end

-- TODO: improve this, possibly with metatables
local client_notifs = {}
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then
        client_notifs[client_id] = {}
    end

    if not client_notifs[client_id][token] then
        client_notifs[client_id][token] = {}
    end

    return client_notifs[client_id][token]
end
local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification,
        })

        vim.defer_fn(function()
            update_spinner(client_id, token)
        end, 100)
    end
end

M.utilities = {
    client_notifs = client_notifs,
    spinner_frames = spinner_frames,
    notify_output = function(command, opts)
        local output = ""
        local notification
        local notify = function(msg, level)
            local notify_opts = vim.tbl_extend(
                "keep",
                opts or {},
                { title = table.concat(command, " "), replace = notification }
            )
            notification = vim.notify(msg, level, notify_opts)
        end
        local on_data = function(_, data)
            output = output .. table.concat(data, "\n")
            notify(output, "info")
        end
        vim.fn.jobstart(command, {
            on_stdout = on_data,
            on_stderr = on_data,
            on_exit = function(_, code)
                if #output == 0 then
                    notify("No output of command, exit code: " .. code, "warn")
                end
            end,
        })
    end,
    get_notif_data = get_notif_data,
    update_spinner = update_spinner,
    format_title = function(title, client_name)
        return client_name .. (#title > 0 and ": " .. title or "")
    end,
    format_message = function(message, percentage)
        return (percentage and percentage .. "%\t" or "") .. (message or "")
    end
}

function M.setup()
	vim.notify = require('notify')

	wk.register({
		['<Leader>N'] = {
			'<Cmd>lua require("lxs.plugin_settings.notify").notifications()<CR>',
			'Notifications',
		},
	}, {
		mode = 'n',
		noremap = true,
		silent = true,
	})
end

return M
