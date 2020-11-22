local extensions = require('el.extensions')
local subscribe = require('el.subscribe')
local M = {}

local file_namer = function(_window, buffer)
    return vim.fn.fnamemodify(buffer.name, ':p:~:.')
end

local git_branch = function(window, buffer)
    return extensions.git_branch(window, buffer)
end

local generator = function(_window, buffer)
    local segments = {}

    table.insert(segments, extensions.mode)

    table.insert(segments, '%<')
    table.insert(segments, file_namer)
    table.insert(segments, '%m%r')
    table.insert(segments,
        subscribe.buf_autocmd(
            "el_git_branch",
            "BufEnter",
            git_branch
        )
    )

    table.insert(segments, '%=')
    table.insert(segments, '%n')
    table.insert(segments, vim.bo.filetype)

    table.insert(segments, '%=')
    table.insert(segments, vim.bo.fileencoding)
    table.insert(segments, vim.bo.fileformat)
    table.insert(segments, '%l:%c')
    table.insert(segments, '%l:%c')
    table.insert(segments, '%p%%')
    return segments
end

function M.setup()
    require('el').setup({ generator = generator })
end

return M
