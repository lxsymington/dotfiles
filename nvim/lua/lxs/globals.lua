function _G.P(v)
	print(vim.inspect(v))
	return v
end

function _G.ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match('^lxs') then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end
