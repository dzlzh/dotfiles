local M = {}

function M.setup()
    local signs = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
        [vim.diagnostic.severity.INFO] = " ",
    }

    vim.diagnostic.config({
        signs = { text = signs },
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
end

return M
