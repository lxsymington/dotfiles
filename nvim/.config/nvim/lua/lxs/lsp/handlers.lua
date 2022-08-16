local notify_utils = require('lxs.plugin_settings.notify').utilities
local M = {}

-- LSP Handlers ------------------------
function M.setup()
	vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		local lvl = ({
			'ERROR',
			'WARN',
			'INFO',
			'DEBUG',
		})[result.type]

		vim.notify({ result.message }, lvl, {
			title = 'LSP | ' .. client.name,
			timeout = 10000,
			keep = function()
				return lvl == 'ERROR' or lvl == 'WARN'
			end,
		})
	end

	vim.lsp.handlers['$/progress'] = function(_, result, ctx)
		local client_id = ctx.client_id

		local val = result.value

		if not val.kind then
			return
		end

		local notif_data = notify_utils.get_notif_data(client_id, result.token)

		if val.kind == 'begin' then
			local message = notify_utils.format_message(val.message, val.percentage)

			notif_data.notification = vim.notify(message, 'info', {
				title = notify_utils.format_title(
					val.title,
					vim.lsp.get_client_by_id(client_id).name
				),
				icon = notify_utils.spinner_frames[1],
				timeout = false,
				hide_from_history = false,
			})

			notif_data.spinner = 1
			notify_utils.update_spinner(client_id, result.token)
		elseif val.kind == 'report' and notif_data then
			notif_data.notification = vim.notify(
				notify_utils.format_message(val.message, val.percentage),
				'info',
				{
					replace = notif_data.notification,
					hide_from_history = false,
				}
			)
		elseif val.kind == 'end' and notif_data then
			notif_data.notification = vim.notify(
				val.message and notify_utils.format_message(val.message) or 'Complete',
				'info',
				{
					icon = '',
					replace = notif_data.notification,
					timeout = 3000,
				}
			)

			notif_data.spinner = nil
		end
	end

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = 'rounded',
	})

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = 'rounded',
	})
end

return M
