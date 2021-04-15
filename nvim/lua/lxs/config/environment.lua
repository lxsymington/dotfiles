local M = {}

-- ENVIRONMENT -------------------------
function M.setup()
    -- Establish which environment vim/neovim is running in.
    if vim.g.env == nil then
        if vim.fn.has('win64') + vim.fn.has('win32') + vim.fn.has('win16') > 0 then
            vim.g.env = 'WINDOWS'
        elseif vim.fn.has('macunix') then
            vim.g.env = 'MACOS'
        elseif vim.fn.has('unix') then
            vim.g.env = 'UNX'
        else
            vim.g.env = vim.cmd(
                            [[toupper(substitute(system('uname'), '\n', '', ''))]])
        end
    end

    -- Example -----------------------------
    -- if vim.g.env == 'WINDOWS' then
    --   Enable Windows specific settings/plugins
    -- end

    -- if vim.g.env == 'LINUX' then
    --   Enable Linux specific settings/plugins
    -- end

    -- if vim.g.env == 'DARWIN' then
    --   Enable MacOS specific settings/plugins
    -- end

    -- if vim.g.env == 'MINGW' then
    --   Enable MinGW specific settings/plugins (Git Bash, mainly)
    -- end

    -- ENVIRONMENT -------------------------
    if vim.g.env == 'WINDOWS' then
        vim.g.behave = 'mswin'
        vim.o.shell = 'powershell.exe'
        vim.o.shellcmdflag = [[ -NoLogo -ExecutionPolicy RemoteSigned -Command]]
        vim.o.shellquote = [[shellpipe=| shellxquote=]]
        vim.o.shellredir = [[| Out-File -Encoding UTF8]]
        vim.g.python_host_prog =
            'C:\\Users\\lsymington\\scoop\\shims\\python2.EXE'
        vim.g.python3_host_prog =
            'C:\\Users\\lsymington\\scoop\\shims\\python3.EXE'
    elseif vim.g.env == 'DARWIN' then
        vim.o.shell = [[/usr/local/bin/fish]]
    elseif vim.g.env == 'LINUX' then
        vim.o.shell = [[/usr/bin/fish]]
    end
end

return M
