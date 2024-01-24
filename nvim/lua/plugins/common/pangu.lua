return {
    "hotoo/pangu.vim",
    event = "BufEnter *.md",
    config = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "md",
            command = "PanguAll",
        })
    end,
}
