function _G.P(v)
	print(vim.inspect(v))
	return v
end

function _G.ReloadConfig()
	vim.notify('Reloading Neovim configuration…', 'info')
	for name, _ in pairs(package.loaded) do
		if name:match('^lxs') or name:match('^' .. vim.g.colors_name) then
			package.loaded[name] = nil
		end
	end

	vim.api.nvim_clear_autocmds('*')
	local vimrc_ok, vimrc_ret = pcall(dofile, vim.env.MYVIMRC)
	if not vimrc_ok then
		vim.notify(vimrc_ret, 'error')
	end
	vim.cmd('PackerCompile')
	vim.notify('Packer Recompiled', 'info')

	-- Fix feline highlights
	local ok, feline = pcall(require, 'feline')
	if ok then
		feline.reset_highlights()
	end
end
