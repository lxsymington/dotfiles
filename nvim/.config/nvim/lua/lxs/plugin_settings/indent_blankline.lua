local M = {}

-- INDENT BLANKLINE --------------------
function M.setup()
	vim.g.indent_blankline_char = '┊'
	vim.g.indent_blankline_space_char = '┈'
	vim.g.indent_blankline_space_char_blankline = ' '
	vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
	vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
	vim.g.indent_blankline_char_highlight = 'LineNr'
	vim.g.indent_blankline_use_treesitter = true
	vim.g.indent_blankline_show_current_context = true
end

return M
