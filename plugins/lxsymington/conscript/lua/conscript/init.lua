local Job = require('plenary.job')
local filereadable = vim.fn.filereadable
local json = vim.json
local M = {}

--[[
 TODO:
 - watch the package.json for changes
 - expose <Plug>bindings for running the scripts
 - parse command output if useful otherwise notify of completion
]]

M.regiments = {
	'*.ts',
	'*.cts',
	'*.mts',
	'*.tsx',
	'*.js',
	'*.cjs',
	'*.mjs',
	'*.jsx',
	'*.json',
	'*.json5',
	'*.yaml',
	'*.yml',
}

--  TODO: make it so that this only stores one set of scripts and can be easily cleared
M.cache = {}

function M.scout()
	local is_node_project = filereadable('package.json')

	if not is_node_project then
		vim.api.nvim_clear_autocmds({ group = 'ConscriptScout' })
		return
	end

	vim.notify('Node project detected, Enrolling conscript 💂', vim.log.levels.INFO)

	local conscript_augroup = vim.api.nvim_create_augroup('ConscriptScout', { clear = true })

	vim.api.nvim_create_autocmd('BufEnter', {
		pattern = M.regiments,
		callback = M.patrol,
		group = conscript_augroup,
	})

	local package_json_path = vim.loop.cwd() .. '/package.json'

	local package_json_handle = io.open(package_json_path, 'r')

	if not package_json_handle then
		return
	end

	local package_json_contents = package_json_handle:read('*a')
	package_json_handle:close()
	local package_json = json.decode(package_json_contents)

	if not #package_json.scripts then
		vim.notify('No scripts found', vim.log.levels.INFO)
		return
	end

	-- TODO: improve this
	M.cache = vim.tbl_extend(M.cache, package_json.scripts)
end

function M.exercises()
	local script_names = vim.tbl_keys(M.cache)

	vim.ui.select(script_names, {
		prompt = 'Select a script to run',
		format_item = function(item)
			return string.format('%s | %s', item, M.cache[item])
		end,
	}, M.drill)
end

function M.patrol(...)
	vim.pretty_print(...)
	--[[ {
        buf = 7,
        event = "BufEnter",
        file = "/home/lxs/Development/secclint/src/filter.ts",
        group = 65,
        id = 46,
        match = "/home/lxs/Development/secclint/src/filter.ts"
    } ]]

	-- vim.api.nvim_buf_get_commands(buffer: number, opts: table<string, any>)
	-- vim.api.nvim_buf_create_user_command('Make',)
end

function M.drill(script, idx)
	Job
		:new({
			command = 'npm',
			args = { 'run', script },
			cwd = vim.loop.cwd(),
			on_exit = function(...)
				vim.pretty_print(...)
			end,
		})
		:start()
end

return M
