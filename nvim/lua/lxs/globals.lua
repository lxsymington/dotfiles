function _G.P(v)
	print(vim.inspect(v))
	return v
end

function _G.ReloadConfig()
	vim.notify("Reloading Neovim configuration…", "info")
	for name, _ in pairs(package.loaded) do
		if name:match("^lxs") or name:match("^" .. vim.g.colors_name) then
			package.loaded[name] = nil
		end
	end

	vim.api.nvim_exec([[ autocmd! * ]], false)
	dofile(vim.env.MYVIMRC)

	if not vim.fn.expand("%:t"):match("^dependencies.lua$") then
		vim.cmd("PackerCompile")
	end

	-- Fix feline highlights
	local ok, feline = pcall(require, "feline")
	if ok then
		feline.reset_highlights()
	end
end
