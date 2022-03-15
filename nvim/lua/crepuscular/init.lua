if vim.api.nvim_get_option('background') == 'dark' then
	return require(vim.g.colors_name .. '.dusk')
else
	return require(vim.g.colors_name .. '.dawn')
end
