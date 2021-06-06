local g = vim.g
local opt = vim.opt
local has = vim.fn.has

local M = {}

-- ENVIRONMENT -------------------------
function M.setup()
	-- Establish which environment vim/neovim is running in.
	if g.env == nil then
		if has("win64") + has("win32") + has("win16") > 0 then
			g.env = "WINDOWS"
		elseif has("macunix") then
			g.env = "MACOS"
		elseif has("unix") then
			g.env = "UNX"
		else
			g.env = vim.cmd([[toupper(substitute(system('uname'), '\n', '', ''))]])
		end
	end

	-- Example -----------------------------
	-- if g.env == 'WINDOWS' then
	--   Enable Windows specific settings/plugins
	-- end

	-- if g.env == 'LINUX' then
	--   Enable Linux specific settings/plugins
	-- end

	-- if g.env == 'DARWIN' then
	--   Enable MacOS specific settings/plugins
	-- end

	-- if g.env == 'MINGW' then
	--   Enable MinGW specific settings/plugins (Git Bash, mainly)
	-- end

	-- ENVIRONMENT -------------------------
	if g.env == "WINDOWS" then
		g.behave = "mswin"
		opt.shell = "powershell.exe"
		opt.shellcmdflag = [[ -NoLogo -ExecutionPolicy RemoteSigned -Command]]
		opt.shellquote = [[shellpipe=| shellxquote=]]
		opt.shellredir = [[| Out-File -Encoding UTF8]]
		g.python_host_prog = "C:\\Users\\lsymington\\scoop\\shims\\python2.EXE"
		g.python3_host_prog = "C:\\Users\\lsymington\\scoop\\shims\\python3.EXE"
	elseif g.env == "DARWIN" then
		opt.shell = [[/usr/local/bin/fish]]
	elseif g.env == "LINUX" then
		opt.shell = [[/usr/bin/fish]]
	end
end

return M
