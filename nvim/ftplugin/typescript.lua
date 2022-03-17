-- TypeScript files
local M = {}


--[[ Example: File-change detection                          *watch-file*
    1. Save this code to a file.
    2. Execute it with ":luafile %".
    3. Use ":Watch %" to watch any file.
    4. Try editing the file from another text editor.
    5. Observe that the file reloads in Nvim (because on_change() calls
       |:checktime|).

    local w = vim.loop.new_fs_event()
    local function on_change(err, fname, status)
      -- Do work...
      vim.api.nvim_command('checktime')
      -- Debounce: stop/start.
      w:stop()
      watch_file(fname)
    end
    function watch_file(fname)
      local fullpath = vim.api.nvim_call_function(
        'fnamemodify', {fname, ':p'})
      w:start(fullpath, {}, vim.schedule_wrap(function(...)
        on_change(...) end))
    end
    vim.api.nvim_command(
      "command! -nargs=1 Watch call luaeval('watch_file(_A)', expand('<args>'))") ]]

function M.setup()
    local watcher = vim.loop.new_fs_event()

    local function on_change(err, fname, status)
        watcher:stop()

        watch_file(fname)
    end

    function watch_file(fname)
        local fullpath = vim.api.nvim_call_function('fnamemodify', {fname, ':p'})

        watcher:start(fullpath, {}, vim.schedule_wrap(function (...)
            on_change(...)
        end))
    end
end

return M
