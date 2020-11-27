local extensions = require('el.extensions')
local subscribe = require('el.subscribe')
local sections = require('el.sections')
local lsp_statusline = require('el.plugins.lsp_status')
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

    table.insert(segments, '%< ')
    table.insert(segments, sections.highlight('LightBlack', ''))
    table.insert(segments, sections.highlight('LightBlackBG', file_namer))
    table.insert(segments, sections.highlight('LightBlackBG', '%m%r '))
    table.insert(segments, sections.highlight('LightBlackBG',
        subscribe.buf_autocmd(
            "el_file_icon",
            "BufRead",
            function(_, buffer)
                return extensions.file_icon(_, buffer)
            end
        )
    ))
    table.insert(segments, sections.highlight('LightBlackBG', ' '))
    table.insert(segments, sections.highlight('BlueBG', ' '))
    table.insert(segments, sections.highlight('BlueBG',
        subscribe.buf_autocmd(
            "el_git_branch",
            "BufEnter",
            git_branch
        )
    ))
    table.insert(segments, sections.highlight('Blue', ''))

    table.insert(segments, '%=')
    table.insert(segments, sections.highlight('Red', ''))
    table.insert(segments, sections.highlight('RedBG', '%n '))
    table.insert(segments, sections.highlight('LightBlackBG', ' ' .. vim.bo.filetype .. ' '))
    table.insert(segments, sections.highlight('PurpleBG', lsp_statusline.segment))
    table.insert(segments, sections.highlight('Purple', ''))

    table.insert(segments, '%=')
    table.insert(segments, sections.highlight('LightBlack', ''))
    table.insert(segments, sections.highlight('LightBlackBG', vim.bo.fileencoding .. ' '))
    table.insert(segments, sections.highlight('GreyBG', ' ' .. vim.bo.fileformat .. ' '))
    table.insert(segments, sections.highlight('LightGreyBG', ' %l:%c '))
    table.insert(segments, sections.highlight('WhiteBG', ' %p%%'))
    table.insert(segments, sections.highlight('White', ''))
    return segments
end

function M.setup()
    require('el').setup({ generator = generator })
end

return M
