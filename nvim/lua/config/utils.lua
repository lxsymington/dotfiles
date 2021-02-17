local M = {}

function M.setup()
    function NumberToggle()
        vim.o.nu = true
        if vim.wo.rnu then
            vim.wo.rnu = false
        else
            vim.wo.rnu = true
        end
    end
    -- Toggle betwen normal and relative line numbers
    vim.cmd [[ command! NumberToggle lua NumberToggle() ]]
end

return M
