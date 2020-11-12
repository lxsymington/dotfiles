local vimp = require('vimp')

-- Convenient normal mode
vimp.imap('jj', '<esc>')

-- Switch pane postion shortcuts
vimp.nmap('<C-J>', '<C-w><C-J>')
vimp.nmap('<C-K>', '<C-w><C-K>')
vimp.nmap('<C-H>', '<C-w><C-H>')
vimp.nmap('<C-L>', '<C-w><C-L>')

-- Open init.vim in a tab
vimp.nmap('<leader>ev', function()
    vim.cmd('tabedit $MYVIMRC')
end)

-- CLear highlighting
vimp.nmap('<leader><space>', function()
    vim.cmd('nohlsearch')
end)

-- Toggle relative numbers
vimp.nnoremap('<leader>#', function()
    vim.cmd('call NumberToggle()')
end)
