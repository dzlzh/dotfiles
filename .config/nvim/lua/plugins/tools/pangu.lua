return {
    "hotoo/pangu.vim",
    ft = "markdown",
    init = function()
        vim.g.pangu_rule_trailing_whitespace = 0
    end,
    config = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("l_pangu", { clear = true }),
            pattern = "*.md",
            command = "PanguAll",
        })
    end,
}
