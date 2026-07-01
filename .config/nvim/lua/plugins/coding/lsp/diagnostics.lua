local M = {}

function M.setup()
    local signs = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN]  = "󰀪 ",
        [vim.diagnostic.severity.HINT]  = "󰌶 ",
        [vim.diagnostic.severity.INFO]  = " ",
    }

    vim.diagnostic.config({
        signs = { text = signs },
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"

        local bufnr, winnr = open_floating_preview(contents, syntax, opts, ...)
        if bufnr and winnr then
            vim.api.nvim_win_set_option(winnr, "winblend", 20)
        end

        return bufnr, winnr
    end

    require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
