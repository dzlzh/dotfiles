return {
    "mhartington/formatter.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("formatter").setup({
            filetype = {
                go = {
                    require("formatter.filetypes.go").gofumpt,
                    require("formatter.filetypes.go").goimports,
                },
            },
        })

        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup("__formatter__", { clear = true }),
            pattern = "*.go",
            command = "FormatWrite",
        })
    end,
}
