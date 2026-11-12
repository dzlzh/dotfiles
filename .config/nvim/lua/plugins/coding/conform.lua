local supported_filetypes = {
    go = true,
    lua = true,
}

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("ConformFormatexpr", { clear = true }),
            pattern = "*",
            callback = function(args)
                if supported_filetypes[vim.bo[args.buf].filetype] then
                    vim.bo[args.buf].formatexpr = "v:lua.require'conform'.formatexpr()"
                end
            end,
        })

        vim.api.nvim_create_user_command("FormatDisable", function()
            vim.b.disable_autoformat = true
        end, { desc = "Disable format-on-save for this buffer" })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
        end, { desc = "Enable format-on-save for this buffer" })
    end,
    opts = {
        formatters_by_ft = {
            go = { "goimports", "gofumpt" },
            lua = { "stylua" },
        },
        format_on_save = function(bufnr)
            if
                vim.b[bufnr].disable_autoformat
                or vim.b[bufnr].large_file
                or not supported_filetypes[vim.bo[bufnr].filetype]
            then
                return
            end
            return { timeout_ms = 1000, lsp_format = "never" }
        end,
        notify_on_error = true,
        notify_no_formatters = true,
    },
}
