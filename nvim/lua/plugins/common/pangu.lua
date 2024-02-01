return {
    "hotoo/pangu.vim",
    ft = "markdown",
    config = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "md",
            command = "PanguAll",
        })
    end,
}
